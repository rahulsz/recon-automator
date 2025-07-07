#!/bin/bash

TARGET=$1
OUTPUT=$2

source utils/logger.sh

log_info "Running gobuster on $TARGET"

# Prompt for wordlist
echo -e "\n🔍 Choose a wordlist:"
echo "1) /usr/share/wordlists/dirb/common.txt"
echo "2) /usr/share/wordlists/rockyou.txt"
echo "3) Custom path"

read -p "Enter option [1-3]: " option

case "$option" in
  1) WORDLIST="/usr/share/wordlists/dirb/common.txt" ;;
  2) WORDLIST="/usr/share/wordlists/rockyou.txt" ;;
  3) 
    read -p "Enter full path to your wordlist: " WORDLIST
    if [ ! -f "$WORDLIST" ]; then
      log_error "Wordlist file not found at $WORDLIST"
      exit 1
    fi
    ;;
  *) 
    log_error "Invalid option selected."
    exit 1
    ;;
esac

# Extract open ports from quick scan (only HTTP/S)
HTTP_PORTS=$(grep -E '^[0-9]+/tcp\s+open\s+(http|https)' "$OUTPUT/quick_scan.txt" | cut -d '/' -f1)

if [ -z "$HTTP_PORTS" ]; then
  log_info "No HTTP(S) ports found in quick scan. Skipping gobuster."
  exit 0
fi

for PORT in $HTTP_PORTS; do
  URL=\"http://$TARGET:$PORT\"
  log_info "Scanning $URL with gobuster..."
  
  gobuster dir -u "$URL" -w "$WORDLIST" -o "$OUTPUT/gobuster-$PORT.txt" || {
    log_error "Gobuster failed on port $PORT"
  }
done
