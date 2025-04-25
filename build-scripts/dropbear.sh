#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
ROOT_DIR=$(realpath "$PROJECT_DIR/../../..")
OUTPUT_DIR="$ROOT_DIR/samples/original"

echo "🔧 Building Dropbear..."

./configure --disable-zlib || true
make PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" -j$(nproc)

mkdir -p "$OUTPUT_DIR"
cp dropbear "$OUTPUT_DIR/dropbear"
cp dbclient "$OUTPUT_DIR/dbclient"
cp dropbearkey "$OUTPUT_DIR/dropbearkey"
cp scp "$OUTPUT_DIR/dropbear_scp"

echo "✅ Exported Dropbear binaries."
