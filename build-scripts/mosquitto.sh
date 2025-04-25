#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building Mosquitto..."

mkdir -p build
cd build
cmake .. -DWITH_STATIC_LIBRARIES=ON -DWITH_SHARED_LIBRARIES=OFF
make -j$(nproc)

mkdir -p "$OUTPUT_DIR"
cp src/mosquitto "$OUTPUT_DIR/mosquitto"

echo "✅ Exported Mosquitto binary."
