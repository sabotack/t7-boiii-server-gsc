#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'

# Check if the first argument is provided
if [ -z "$1" ]; then
    echo "Please provide a new filename as the first argument."
    exit 1
fi

# Check if the second argument is provided and is true
if [ -z "$2" ]; then
    echo "Please provide a second argument."
    exit 1
elif [ "$2" = true ]; then
    uploadGameInterface=true
    echo "The second argument is true."
else
    uploadGameInterface=false
    echo "The second argument is not true."
fi

echo -e "${GREEN}Starting compilation...${NC}"
cmd.exe "/mnt/c/t7compiler/DebugCompiler.exe --compile" || exit 1
echo -e "${GREEN}GSC file compiled successfully.${NC}"

# Rename the file
mv --force compiled.gscc "$1" || exit 1
echo -e "${GREEN}GSC file renamed to $1.${NC}"

# Copy the file to the server
scp -i ~/SSH_KEY_FOR_STRATO.pem -r "$1" debian@130.225.37.75:~/UnrankedServer/boiii/scripts/zm/gametypes >/dev/null || exit 1
echo -e "${GREEN}GSC file copied to the server using SCP.${NC}"

# Copy gameinterface to the server
if [ "$uploadGameInterface" = true ]; then
    scp -i ~/SSH_KEY_FOR_STRATO.pem -r scripts/game_interface/plugins/GameInterface.js debian@130.225.37.75:~/IW4MAdmin-2024.2.5.6/Plugins >/dev/null || exit 1
    echo -e "${GREEN}GameInterface copied to the server using SCP.${NC}"
fi
