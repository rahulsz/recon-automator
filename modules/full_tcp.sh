#!/bin/bash

TARGET=$1
OUTPUT=$2

source utils/logger.sh

log_info "Running full TCP scan on $TARGET"

nmap -T4 -p- "$TARGET" -oN "$OUTPUT/full_tcp.txt" || {
  log_error "Full TCP scan failed"
}
