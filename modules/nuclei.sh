#!/bin/bash

TARGET=$1
OUTPUT=$2

source utils/logger.sh

log_info "Running nuclei on $TARGET"

# Ensure nuclei-templates are present
if [ ! -d "$HOME/.local/nuclei-templates" ]; then
  log_info "nuclei-templates not found. Downloading..."
  nuclei -update-templates || {
    log_error "Failed to download nuclei templates"
    exit 1
  }
fi

echo "$TARGET" | nuclei -t "$HOME/.local/nuclei-templates" -o "$OUTPUT/nuclei.txt" || {
  log_error "Nuclei scan failed"
}
