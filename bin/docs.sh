#!/usr/bin/env python3
import requests
import argparse
import tempfile
import signal
import sys
url = "https://devdocs.io/docs.json"
def hanler():
    def handler(signum, frame):
    temp_dir.cleanup()
    sys.exit(0)

signal.signal(signal.SIGINT, handler)
signal.signal(signal.SIGTERM, handler)

def show():
    r = requests.get(url)
    data = r.json()
    docs = []
    for item in data:
        docs.append((item["slug"], item["mtime"]))
    return docs
def docs():
    pass
def download():
    pass
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--show", help="Show list", action="store_true")
    args = parser.parse_args()

    if args.show:
        show()

    temp_dir = tempfile.TemporaryDirectory()
    print(temp_dir.name)
    
    while true:
        docs()

if __name__ == "__main__":
    main()
