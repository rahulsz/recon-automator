#!/bin/bash
# recon-automator/main.sh

set -e
source utils/logger.sh

TARGET=$1
shift

if [[ -z "$TARGET" ]]; then
  log_error "No target provided. Usage: ./main.sh <target> [--flags]"
  exit 1
fi

# Flags
RUN_QUICK=true
RUN_TCP=true
RUN_UDP=true
RUN_VULN=true
RUN_HTTPX=true
RUN_NUCLEI=true
RUN_GOBUSTER=true

# Handle flags
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --only-nuclei)
      RUN_QUICK=false
      RUN_TCP=false
      RUN_UDP=false
      RUN_VULN=false
      RUN_HTTPX=false
      RUN_GOBUSTER=false
      ;;
    --skip-vuln) RUN_VULN=false ;;
    --skip-httpx) RUN_HTTPX=false ;;
    --skip-nuclei) RUN_NUCLEI=false ;;
    --skip-gobuster) RUN_GOBUSTER=false ;;
    --skip-udp) RUN_UDP=false ;;
    --skip-tcp) RUN_TCP=false ;;
    --skip-quick) RUN_QUICK=false ;;
    *) log_error "Unknown flag: $1"; exit 1 ;;
  esac
  shift
done

OUTPUT_DIR="output/$TARGET"
mkdir -p "$OUTPUT_DIR"
log_info "Created output directory: $OUTPUT_DIR"

# Execute modules
[[ "$RUN_QUICK" == true ]]    && bash modules/quick_scan.sh "$TARGET" "$OUTPUT_DIR"
[[ "$RUN_TCP" == true ]]      && bash modules/full_tcp.sh "$TARGET" "$OUTPUT_DIR"
[[ "$RUN_UDP" == true ]]      && bash modules/udp_scan.sh "$TARGET" "$OUTPUT_DIR"
[[ "$RUN_HTTPX" == true ]]    && bash modules/httpx.sh "$TARGET" "$OUTPUT_DIR"
[[ "$RUN_NUCLEI" == true ]]   && bash modules/nuclei.sh "$TARGET" "$OUTPUT_DIR"
[[ "$RUN_GOBUSTER" == true ]] && bash modules/gobuster.sh "$TARGET" "$OUTPUT_DIR"
[[ "$RUN_VULN" == true ]]     && bash modules/vuln_scan.sh "$TARGET" "$OUTPUT_DIR"

log_info "Recon completed for $TARGET"
