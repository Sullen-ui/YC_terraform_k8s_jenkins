#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

URL="https://httpbin.org/status/"
RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

if [ $RESPONSE_CODE -eq 200 ]; then
    echo "success"
    exit 0
else
    echo "failure. Response status code = $RESPONSE_CODE"
    exit 1
fi