# !/bin/bash

CONTAINER_NAME="autoware_dev_${USER}"

show_help() {
    echo -e "\e[34mUsage:\e[0m $0 [options]"
    echo -e "\e[34mOptions:\e[0m"
    echo -e "  \e[32m--container_name <name>\e[0m    Attach to container name"
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
    --help)
        show_help
        ;;
    *)
        echo -e "\e[31m[ERROR]: Unknown argument $1\e[0m"
        show_help
        ;;
    esac
done

# check if container is running
check_container() {
    if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]]; then
        echo -e "\e[31m[ERROR]: Container $CONTAINER_NAME not running\e[0m"
        exit 1
    fi
}

check_container
echo -e "\e[32m[INFO]: Attaching to container $CONTAINER_NAME\e[0m"
docker exec -it $CONTAINER_NAME bash -c "source /ros_entrypoint.sh && exec bash"
