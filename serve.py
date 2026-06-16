#!/usr/bin/env python3
"""Tiny static server for the demiurge architecture viewer (commons c4).

Serves the repo directory and opens ARCHITECTURE.html in the browser.
The HTML viewer fetches ./ARCHITECTURE.json (the SSOT) over http.

Usage:
    python3 serve.py [PORT]      # default port 8765
"""
import http.server
import socketserver
import os
import sys
import webbrowser

DEFAULT_PORT = 8765
VIEWER = "ARCHITECTURE.html"


def main():
    port = DEFAULT_PORT
    if len(sys.argv) > 1:
        try:
            port = int(sys.argv[1])
        except ValueError:
            print(f"invalid port {sys.argv[1]!r}; using {DEFAULT_PORT}")
            port = DEFAULT_PORT

    # serve the repo dir (this file's directory)
    root = os.path.dirname(os.path.abspath(__file__))
    os.chdir(root)

    handler = http.server.SimpleHTTPRequestHandler
    socketserver.TCPServer.allow_reuse_address = True

    with socketserver.TCPServer(("127.0.0.1", port), handler) as httpd:
        url = f"http://127.0.0.1:{port}/{VIEWER}"
        print(f"demiurge architecture viewer serving {root}")
        print(f"  → {url}")
        print("  (SSOT = ARCHITECTURE.json; Ctrl-C to stop)")
        try:
            webbrowser.open(url)
        except Exception:
            pass
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nstopped.")


if __name__ == "__main__":
    main()
