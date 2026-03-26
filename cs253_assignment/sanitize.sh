#!/bin/bash
# Task 1: The Sanitizer
# Cleans the raw auth.log file and standardizes it into a CSV format.

INPUT_FILE=$1
OUTPUT_FILE="clean_log.csv"

# Using sed to perform multiple operations in one go:
# 1. /\[CORRUPT-DATA\]/d -> Deletes any line containing the exact string [CORRUPT-DATA]
# 2. s/user=root/user=SYS_ADMIN/g -> Replaces user=root with user=SYS_ADMIN
# 3. s/user=admin/user=SYS_ADMIN/g -> Replaces user=admin with user=SYS_ADMIN
# 4. s/|/,/g -> Converts all pipe '|' delimiters to commas ','
sed '/\[CORRUPT-DATA\]/d; s/user=root/user=SYS_ADMIN/g; s/user=admin/user=SYS_ADMIN/g; s/|/,/g' "$INPUT_FILE" > "$OUTPUT_FILE"


