#!/bin/bash

TARGET=$1
OUTPUT=$2

source utils/logger.sh

log_info "Running httpx on $TARGET"

echo "$TARGET" | httpx -o "$OUTPUT/httpx.txt" || {
  log_error "httpx failed"
}
