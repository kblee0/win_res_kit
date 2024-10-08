import socket
import argparse
import logging
import selectors
import traceback


lhost = '0.0.0.0'       # Default server host (to bind)
lport = 9090            # Default server port.
dhost = '127.0.0.1'     # Default destination host.
dport = 22              # Default destination port.
BUFFER_SIZE = 4096      # Default buffer size.
fake_websocket_reply = False

sel = selectors.DefaultSelector()

# Setting up the logger
fmt = "%(asctime)s - [%(levelname)s]: %(message)s"
logging.basicConfig(level=logging.DEBUG, format=fmt)
logger = logging.getLogger(__file__)


def websocket_upgrade(client, extra_data):
    """return a fake websocket reply"""
    buffer = client.recv(BUFFER_SIZE)
    if buffer:
        client.sendall(
            "HTTP/1.1 101 Switching Protocols (Python)\r\nContent-Length: 1048576000000\r\n\r\n".encode('utf-8'))
        logger.info('Websocket upgraded!')


def forward_ws(client, conn, extra_data):
    # Upgrading to Websocket.
    if not extra_data['websocket_handshake']:
        extra_data['websocket_handshake'] = True
        return websocket_upgrade(client, extra_data)

    forward(client, conn, extra_data)


def forward(src, dst, extra_data):
    if extra_data['websocket_handshake']:
        try:
            buffer = src.recv(BUFFER_SIZE)
            if buffer:
                dst.sendall(buffer)
            else:
                sel.unregister(src)
                sel.unregister(dst)

                src.shutdown(socket.SHUT_RDWR)
                dst.shutdown(socket.SHUT_RDWR)

                src.close()
                dst.close()
                logger.info('Connection closed.')
        except OSError as e:
            logger.warning('Socket already closed!')
            logger.warning(e)


def accept(server):
    try:
        client, src_addr = server.accept()
        client.setblocking(False)
        # Establishing a cennection to destination.
        conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        conn.connect((dhost, dport))
        conn.setblocking(False)

        logger.info(
            f'Connection established: {client.getsockname()} -> ? -> {conn.getpeername()}')

        extra_data = {'websocket_handshake': False if fake_websocket_reply else True}

        sel.register(client, selectors.EVENT_READ,
                     data=(forward_ws, client, conn, extra_data))
        sel.register(conn, selectors.EVENT_READ,
                     data=(forward, conn, client, extra_data))

    except ConnectionRefusedError:
        logger.error('Destination connection refused.')
    except Exception:
        logger.error(traceback.format_exc())


def server(lhost, lport, dhost, dport):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
        server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server.setblocking(False)
        server.bind((lhost, lport))
        server.listen()

        sel.register(server, selectors.EVENT_READ, data=(accept, server))
        logger.info(f'Server started on {lhost}:{lport}')

        try:
            while True:
                for key, flag in sel.select():
                    callback, *args = key.data
                    callback(*args)
        except KeyboardInterrupt:
            logger.info('Server closed')


if __name__ == '__main__':
    # Get arguments from terminal.
    parser = argparse.ArgumentParser(
        description="A Simple and Great Port forwarding script :D",
        usage=f"%(prog)s --server {lport} --target {dhost}:{dport}"
    )
    parser.add_argument('--server', metavar='', required=True,
                        help='A port, for a server to liston on.', default=f'{lhost}:{lport}')

    parser.add_argument('--target', metavar='', required=True,
                        help='Distination, e.g: 127.0.0.1:20 or 10.0.0.5:3306')
    parser.add_argument('--fake-ws-reply', action='store_true',
                        help='return "HTTP/1.1 101 Switching Protocol" for a fake Websocket upgrade reply\n (useful for HTTP Custom & HTTP Injector)!')

    args = parser.parse_args()

    # Override default params
    if ':' in args.server:
        shost, sport = args.server.split(':')
        lhost = shost if shost else lhost
        lport = int(sport) if sport else lport
    else:
        lport = int(args.server)

    if ':' in args.target:
        host, port = args.target.split(':')
        dhost = host if host else dhost
        dport = int(port) if port else dport

    fake_websocket_reply = args.fake_ws_reply

    logger.info(f"tunnel: {lhost}:{lport} --> {dhost}:{dport}")
    # start a server.
    server(lhost, lport, dhost, dport)