#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building BusyBox..."

make defconfig
make -j$(nproc)

mkdir -p "$OUTPUT_DIR"
cp busybox "$OUTPUT_DIR/busybox"

echo "✅ Exported BusyBox binary."
