#!/bin/bash

source utils/logger.sh

log_info "[*] Installing required tools..."

REQUIRED_TOOLS=(nmap nuclei httpx gobuster whatweb)

for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &>/dev/null; then
    log_info "Installing $tool..."
    sudo apt install -y "$tool" &>/dev/null && log_success "$tool installed."
  else
    log_success "$tool already installed."
  fi
done
