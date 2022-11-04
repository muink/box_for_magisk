#!/system/bin/sh

data_dir="/data/adb/box"
run_path="${data_dir}/run"
logs_file="${run_path}/runs.log"

log() {
  # Set the timezone to Asia/Jakarta
  export TZ=Asia/Jakarta  
  # Get the current time
  now=$(date +"%I.%M %p %Z")
  case $1 in
    # print the log message in blue
    info) color="\033[1;34m" ;;
    # print the log message in red
    error) color="\033[1;31m" ;;
    # print the log message in yellow
    warn) color="\033[1;33m" ;;
    # print the log message in magenta
    *) color="\033[1;35m" ;;
  esac
  message="${now} [$1]: $2"
  if [ -t 1 ]; then
    echo -e "${color}${message}\033[0m"
  else
    echo "${message}" | tee -a ${logs_file} >> /dev/null 2>&1
  fi
}

stop_box() {
    /data/adb/box/scripts/box.service stop
    log warn "BOX discontinued"
    log warn "Next flush the iptables BOX"
}

stop_box