#!/bin/bash

function find_available_hive_type_ids() {
    # Extract all used typeIds, capture only the number, hide filenames, sort, and save to a temporary file
    grep -hroP "@HiveType\(typeId:\s*\K\d+" . | sort -n > /tmp/used_ids.txt

    # Generate the full range of possible typeIds (0-223), sort them, and save to a temporary file
    seq 0 223 | sort -n > /tmp/all_ids.txt

    # Use comm to find IDs that are in `all_ids` but not in `used_ids`
    available_ids=$(comm -23 /tmp/all_ids.txt /tmp/used_ids.txt)

    # Output the available IDs
    if [ -n "$available_ids" ]; then
        echo "Available HiveType type IDs between 0 and 223:"
        echo "$available_ids"
    else
        echo "No available HiveType type IDs in the range 0-223."
    fi

    # Clean up temporary files
    rm /tmp/used_ids.txt /tmp/all_ids.txt
}

find_available_hive_type_ids
