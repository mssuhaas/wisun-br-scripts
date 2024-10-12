#!/bin/bash
cleanup() {
    echo "Cleaning up and releasing resources..."
    exit 0
}
trap cleanup SIGINT
python3 /home/raspberrypi/Downloads/node_monitoring.py /home/raspberrypi/Downloads/recieved_logs.txt