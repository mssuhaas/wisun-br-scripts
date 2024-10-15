#!/bin/bash
cleanup() {
    echo "Cleaning up and releasing resources..."
    exit 0
}
trap cleanup SIGINT
python3 $HOME/Downloads/node_monitoring.py $HOME/Downloads/recieved_logs.txt