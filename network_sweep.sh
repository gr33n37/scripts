#!/bin/bash

# Function to ping all active hosts on the subnet
ping_subnet() {
    local subnet="$1"
    local timeout=1  # Timeout in seconds

    for i in {1..254}; do
        local ip="$subnet.$i"
        ping -c 1 -W "$timeout" "$ip" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "Host $ip is active."
            # You can perform any additional actions here before running nmap.
        fi
    done
}

# Function to run nmap scan on the subnet
scan_subnet_with_nmap() {
    local subnet="$1"
    nmap -sn "$subnet.0/24"  # Scans all 254 IPs in the subnet
}

# Main script
main() {
    local subnet="$1"

    if [ -z "$subnet" ]; then
        echo "Usage: $0 <IP_ADDRESS>"
        exit 1
    fi

    echo "Detected subnet: $subnet"
    ping_subnet "$subnet"
    scan_subnet_with_nmap "$subnet"
}

main "$@"
