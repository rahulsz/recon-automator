#!/bin/bash

log_info() {
  echo -e "[\033[1;34mINFO\033[0m] $1"
}

log_error() {
  echo -e "[\033[1;31mERROR\033[0m] $1"
}

log_success() {
  echo -e "[\033[1;32mSUCCESS\033[0m] $1"
}
