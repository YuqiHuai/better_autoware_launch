# !/bin/bash

CONTAINER_NAME="autoware_dev_${USER}"
USE_MULTI_CONTAINER=false
GREAT_GRAND_PARENT=$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")

show_help() {
    echo -e "\e[34mUsage:\e[0m $0 [options]"
    echo -e "\e[34mOptions:\e[0m"
    echo -e "  \e[32m--container_name <name>\e[0m    Set container name"
    echo -e "  \e[32m--use_multi_container\e[0m      Enable multi-container mode"
    echo -e "  \e[32m--help\e[0m                     Show this help message"
    exit 0
}

# Parse named arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
    --container_name)
        CONTAINER_NAME="$2"
        shift 2
        ;;
    --use_multi_container)
        USE_MULTI_CONTAINER=true
        shift
        ;;
    --help)
        show_help
        ;;
    *)
        echo -e "\e[31m[ERROR]: Unknown argument $1\e[0m"
        show_help
        ;;
    esac
done

# check if image is built
check_image() {
    if [[ "$(docker images -q $IMAGE_NAME 2>/dev/null)" == "" ]]; then
        echo -e "\e[31m[ERROR]: Image $IMAGE_NAME not found\e[0m"
        exit 1
    fi
}

if [[ "$USE_MULTI_CONTAINER" == true ]]; then
    IMAGE_NAME="sora_autoware_multi_container:latest"
else
    IMAGE_NAME="sora_autoware:latest"
fi

check_image

# check if container is running
if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" != "" ]]; then
    echo -e "\e[31m[ERROR]: Container $CONTAINER_NAME already running\e[0m"
    exit 1
fi

rocker --nvidia --privileged --x11 --user \
    --volume $GREAT_GRAND_PARENT/data/autoware_map:$HOME/autoware_map \
    --volume $GREAT_GRAND_PARENT:$HOME/better_autoware_launch \
    --name $CONTAINER_NAME \
    --detach \
    -- $IMAGE_NAME

echo -e "\e[32m[INFO]: Started container $CONTAINER_NAME\e[0m"
