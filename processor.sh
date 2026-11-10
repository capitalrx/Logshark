#!/usr/bin/env bash
set -euo pipefail

NOW=$(date +"%Y-%m-%d_%H-%M-%S")

echo "Downloading input from ${S3_INPUT_URI}..."
aws s3 cp "${S3_INPUT_URI}" input.zip

echo "Running LogShark..."

dotnet /app/out/LogShark.dll input.zip

if [[ ! -d "./Output" ]]; then
    echo "Output directory was not created."
    exit 1
fi

echo "Uploading results to ${S3_OUTPUT_URI}..."
aws s3 cp ./Output/ "${S3_OUTPUT_URI}${NOW}/" \
    --recursive

echo "Done."
