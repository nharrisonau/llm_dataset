#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building dnsmasq..."

make -j$(nproc)

mkdir -p "$OUTPUT_DIR"
cp src/dnsmasq "$OUTPUT_DIR/dnsmasq"

echo "✅ Exported dnsmasq binary."
