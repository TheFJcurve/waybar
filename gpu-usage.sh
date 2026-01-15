#!/bin/bash

# Get GPU utilization using nvidia-smi
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# Output the percentage
echo "$gpu_usage"
