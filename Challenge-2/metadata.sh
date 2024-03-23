#!/bin/bash

metadata=$(curl -sH Metadata:true "http://169.254.169.254/metadata/instance?api-version=2019-08-15")

location=$(echo $metadata | jq -r '.compute.location')
resource_group=$(echo $metadata | jq -r '.compute.resourceGroupName')
vm_name=$(echo $metadata | jq -r '.compute.name')
vm_size=$(echo $metadata | jq -r '.compute.vmSize')
subscription_id=$(echo $metadata | jq -r '.compute.subscriptionId')
os_type=$(echo $metadata | jq -r '.compute.osType')
os_version=$(echo $metadata | jq -r '.compute.osVersion')

echo "{"
echo '  "provider": "Azure",'
echo '  "metadata": {'
echo '    "location": "'"$location"'",'
echo '    "resource_group": "'"$resource_group"'",'
echo '    "vm_name": "'"$vm_name"'",'
echo '    "vm_size": "'"$vm_size"'",'
echo '    "subscription_id": "'"$subscription_id"'",'
echo '    "os_type": "'"$os_type"'",'
echo '    "os_version": "'"$os_version"'"'
echo "  }"
echo "}"
