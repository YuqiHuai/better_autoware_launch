#!/bin/bash

# Default values
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# dockerfile="$SCRIPT_DIR/multi_container.dockerfile"
# image_name="sora_autoware_multi_container:latest"
BUILD_MULTI_CONTAINER=false

# Function to display help message
show_help() {
    echo -e "\e[34mUsage:\e[0m $0 [options]"
    echo -e "\e[34mOptions:\e[0m"
    echo -e "  \e[32m--multi_container\e[0m     Build the multi-container image"
    echo -e "  \e[32m--help\e[0m                Show this help message"
    exit 0
}
# Parse named arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --multi_container)
            BUILD_MULTI_CONTAINER=true
            shift
            ;;
        --help)
            show_help
            ;;
        *)
            echo -e "\e[31mError: Unknown argument $1\e[0m"
            show_help
            exit 1
            ;;
    esac
done

build_image() {
    dockerfile=$1
    image_name=$2
    # Check if the Dockerfile exists
    if [[ -f "$dockerfile" ]]; then
        echo -e "\e[32mFound specified dockerfile ...\e[0m"
    else
        echo -e "\e[31mError: Dockerfile not found at $dockerfile\e[0m"
        exit 1
    fi
    # Print the image name
    echo -e "\e[32mUsing image name: $image_name\e[0m"
    # Build the Docker image
    docker image build -t $image_name -f $dockerfile .
}

if [[ "$BUILD_MULTI_CONTAINER" == true ]]; then
    build_image "$SCRIPT_DIR/multi_container.dockerfile" "sora_autoware_multi_container:latest"
else
    build_image "$SCRIPT_DIR/container.dockerfile" "sora_autoware:latest"
fi