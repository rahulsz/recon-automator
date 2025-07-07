#!/bin/bash

TARGET=$1
OUTPUT=$2

source utils/logger.sh

log_info "Running quick scan on $TARGET"

nmap -T4 -F "$TARGET" -oN "$OUTPUT/quick_scan.txt" || {
  log_error "Quick scan failed"
}
