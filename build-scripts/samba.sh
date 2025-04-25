#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building Samba..."

# Samba uses waf build system
./configure --enable-static --disable-shared --prefix="$PROJECT_DIR/build"
make -j$(nproc)
make install

mkdir -p "$OUTPUT_DIR"

# Copy key server binaries
cp build/sbin/smbd "$OUTPUT_DIR/smbd"
cp build/sbin/nmbd "$OUTPUT_DIR/nmbd"

echo "✅ Exported Samba binaries."
