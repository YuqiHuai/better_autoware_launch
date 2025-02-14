# Better Autoware Launch

> Run autoware, the apollo style.

## Installation

1. Uninstall rocker from system

2. Install rocker from https://github.com/YuqiHuai/rocker

3. Builld autoware images by running
   ```
   bash docker/build/build_docker.sh
   bash docker/build/build_docker.sh --multi_container
   ```

4. Launch Autoware container by running
   ```
   bash docker/scripts/dev_start.sh
   ```

5. Enter Autoware container by running
   ```
   bash docker/scripts/dev_into.sh
   ```

## Usage

1. Launch autoware container with or without ROS2 being isolated
   ```
   ❯ bash docker/scripts/dev_start.sh --help
   Usage: docker/scripts/dev_start.sh [options]
   Options:
     --container_name <name>    Set container name
     --use_multi_container      Enable multi-container mode
     --help                     Show this help message
   ```

2. Enter autoware container
   ```
   Usage: docker/scripts/dev_into.sh [options]
   Options:
     --container_name <name>    Attach to container name
     --help                     Show this help message
   ```
