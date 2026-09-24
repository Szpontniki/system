#!/bin/sh

# This script ensures that all submodules are using matching api-schemas.

hashes=$(git submodule status --recursive | awk '$2 ~ /\/api-schema$/ { print $1 }')
unique_hashes=$(echo "$hashes" | sort -u)
unique_hashes_length=$(echo "$unique_hashes" | wc -w)

if [ "$unique_hashes_length" -eq 1 ]; then
	first_hash=$(echo $hashes | awk '{ print $1 }')

	echo "All modules are using the same api-schema hash ($first_hash)."
	exit 0
else
	echo "Some modules are depending on different api-schema hashes: $unique_hashes."
	exit 1
fi
