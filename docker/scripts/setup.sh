#!/bin/bash

SCRIPT_DIR=$(readlink -f "$(dirname "$0")")
WORKSPACE_ROOT="$SCRIPT_DIR/../.."

# Define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# Check if ansible-galaxy is installed
if ! command -v ansible-galaxy >/dev/null 2>&1; then
  echo -e "${RED}ansible-galaxy is not installed${NC}"
  exit 1
fi

# Check if ansible-galaxy is installed
if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo -e "${RED}ansible-playbook is not installed${NC}"
  exit 1
fi


echo -e "${GREEN}Setting up autoware_map ...${NC}"
SAMPLE_MAP_PLANNING_DIR=$WORKSPACE_ROOT/data/autoware_map/sample-map-planning
if [ -d "$SAMPLE_MAP_PLANNING_DIR" ]; then
    echo -e "${GREEN}Sample map planning already installed${NC}"
else
    echo -e "${GREEN}Downloading sample map planning ...${NC}"
    gdown -O $WORKSPACE_ROOT/data/autoware_map/ 'https://docs.google.com/uc?export=download&id=1499_nsbUbIeturZaDj7jhUownh5fvXHd'
    unzip -d $WORKSPACE_ROOT/data/autoware_map $WORKSPACE_ROOT/data/autoware_map/sample-map-planning.zip
    rm $WORKSPACE_ROOT/data/autoware_map/sample-map-planning.zip
fi

echo -e "${GREEN}Setting up autoware_data ...${NC}"
AUTOWARE_DATA_DIR=$WORKSPACE_ROOT/data/autoware_data

# install autoware_data
cd autoware
ansible-galaxy collection install -f -r "ansible-galaxy-requirements.yaml"
ansible-playbook autoware.dev_env.download_artifacts -e "data_dir=$AUTOWARE_DATA_DIR" --ask-become-pass

echo "================"
echo -e "${GREEN}Setup completed.${NC}"
echo "================"
