#!/bin/bash

TARGET=$1
OUTPUT=$2

source utils/logger.sh

log_info "Running vulnerability scan on $TARGET"

nmap -sV --script vuln "$TARGET" -oN "$OUTPUT/vuln_scan.txt" || {
  log_error "Vulnerability scan failed"
}
