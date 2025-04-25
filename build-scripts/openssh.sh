#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building OpenSSH..."

./configure --prefix="$PROJECT_DIR/build" --without-openssl --disable-strip || true
make -j$(nproc)
make install

mkdir -p "$OUTPUT_DIR"
cp build/bin/ssh "$OUTPUT_DIR/ssh"
cp build/sbin/sshd "$OUTPUT_DIR/sshd"

echo "✅ Exported OpenSSH binaries."
