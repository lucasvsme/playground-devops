from http.server import HTTPServer, HTTPStatus, BaseHTTPRequestHandler
from socketserver import TCPServer
from os import getenv

class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = b'{"status":"up"}'
        self.send_response(HTTPStatus.OK)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', len(body))
        self.end_headers()
        self.wfile.write(body)

host, port = ('', int(getenv('PORT')))

server = TCPServer((host, port), RequestHandler)
server.serve_forever()
