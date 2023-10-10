#!/bin/bash

usage() {
    echo "Usage:"
    echo "  groupenv <group-name> [-q]"
    echo "  groupenv <group-name> <config-file> [-q]"
    echo ""
    echo "Options:"
    echo "  -q: Quiet mode (suppress output except for errors)"
    echo ""
    echo "By default, the script looks for 'groupenv.json' in the current directory."
}

QUIET_MODE=0

if [[ "$#" -gt 1 && "${!#}" == "-q" ]]; then
    QUIET_MODE=1
    set -- "${@:1:$#-1}"
fi


if [[ -z "$1" ]]; then
    echo "Error: No group name specified."
    usage
    exit 1
fi

GROUP="$1"

if [[ -z "$2" ]]; then
    CONFIG_FILE="groupenv.json"
else
    CONFIG_FILE="$2"
fi

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: Config file '$CONFIG_FILE' does not exist."
    usage
      exit 1
fi

if [[ "$QUIET_MODE" -eq 0 ]]; then
    echo "Loading group '$GROUP' from '$CONFIG_FILE'..."
fi

GROUP_CONTENT=$(sed -n "/\"$GROUP\": \[/,/\]/p" "$CONFIG_FILE")

if [[ -z "$GROUP_CONTENT" ]]; then
    echo "Error: Group '$GROUP' does not exist in the config file."
    exit 1
fi

while IFS= read -r line; do
    if [[ $line =~ \"([A-Z0-9_]+)\":\ \"([A-Za-z0-9_]+)\" ]]; then
        ENV_VAR="${BASH_REMATCH[1]}"
        ENV_VAL="${BASH_REMATCH[2]}"
        export "$ENV_VAR=$ENV_VAL"
        if [[ "$QUIET_MODE" -eq 0 ]]; then
            echo "Exported $ENV_VAR=$ENV_VAL"
        fi
    fi
done <<< "$GROUP_CONTENT"