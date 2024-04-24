#!/bin/bash

# Function to check for kernel panic, hang, or crash messages in system logs
check_kernel_health() {
    # Check for kernel panic messages
    if grep -q "Kernel panic" /var/log/syslog; then
        echo "Kernel panic detected. Rebooting the system..."
        reboot
    fi
    
    # Check for kernel hang messages
    if grep -q "hung_task_timeout_secs" /var/log/syslog; then
        echo "Kernel hang detected. Rebooting the system..."
        reboot
    fi
    
    # Check for kernel crash messages
    if grep -q "Oops" /var/log/syslog; then
        echo "Kernel crash detected. Rebooting the system..."
        reboot
    fi
}

# Main function
main() {
    # Check for kernel health issues in system logs
    check_kernel_health
}

# Call the main function
main
