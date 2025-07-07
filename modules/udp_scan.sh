#!/bin/bash

TARGET=$1
OUTPUT=$2

source utils/logger.sh

log_info "Running UDP scan on $TARGET"

nmap -sU --top-ports 100 "$TARGET" -oN "$OUTPUT/udp_scan.txt" || {
  log_error "UDP scan failed"
}
