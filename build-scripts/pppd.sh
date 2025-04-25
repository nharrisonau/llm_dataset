#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building pppd..."

make -C pppd -j$(nproc)

mkdir -p "$OUTPUT_DIR"
cp pppd/pppd "$OUTPUT_DIR/pppd"

echo "✅ Exported PPP daemon binary."
