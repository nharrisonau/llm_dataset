#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building strongSwan..."

./configure --enable-static --disable-shared --prefix="$PROJECT_DIR/build"
make -j$(nproc)
make install

mkdir -p "$OUTPUT_DIR"

# Copy main daemon
cp build/libexec/ipsec/charon "$OUTPUT_DIR/charon"

# (Optional) If you want more, copy ipsec frontend tools
cp build/sbin/ipsec "$OUTPUT_DIR/ipsec_frontend" || true

echo "✅ Exported strongSwan binaries."
