#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building OpenVPN..."

autoreconf -vi
./configure --enable-static --disable-shared --prefix="$PROJECT_DIR/build"
make -j$(nproc)
make install

mkdir -p "$OUTPUT_DIR"
cp build/sbin/openvpn "$OUTPUT_DIR/openvpn"

echo "✅ Exported OpenVPN binary."
