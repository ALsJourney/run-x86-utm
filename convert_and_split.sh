#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

# Check for the correct number of arguments
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <path_to_ova_file>"
	exit 1
fi

OVA_FILE="$1"

# Check if the OVA file exists and is readable
if [ ! -r "$OVA_FILE" ]; then
	echo "Error: The provided OVA file does not exist or is not readable."
	exit 1
fi

# Extract the OVA file
echo "Extracting $OVA_FILE..."
tar -xvf "$OVA_FILE"

# Count the number of .vmdk files in the directory
VMDK_COUNT=$(ls *.vmdk 2>/dev/null | wc -l)

# Check if no .vmdk files were found
if [ "$VMDK_COUNT" -eq 0 ]; then
	echo "No .vmdk files found after extracting the OVA file."
	exit 1
fi

# Extract the base name of the OVA file to name the output .qcow2 file
BASE_NAME=$(basename -s .ova "$OVA_FILE")
OUTPUT_FILE="$BASE_NAME.qcow2"

# Handle single or multiple .vmdk files
if [ "$VMDK_COUNT" -eq 1 ]; then
	echo "Found 1 .vmdk file."

	VMDK_FILE=$(ls *.vmdk)

	echo "Converting $VMDK_FILE to $OUTPUT_FILE..."
	qemu-img convert -O qcow2 "$VMDK_FILE" "$OUTPUT_FILE"

else
	echo "Found $VMDK_COUNT .vmdk files."

	# Combine all the .vmdk parts and convert them into a single .qcow2 file
	VMDK_FILES=$(ls *.vmdk | sort) # Sorting ensures the correct sequence

	echo "Converting multiple .vmdk files to $OUTPUT_FILE..."
	qemu-img convert -O qcow2 $VMDK_FILES "$OUTPUT_FILE"
fi

echo "Conversion was successful."
