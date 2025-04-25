#!/bin/bash
set -e
set -x

PROJECT_DIR=$(pwd)
ROOT_DIR=$(realpath "$PROJECT_DIR/../../..")
OUTPUT_DIR="$ROOT_DIR/samples/original"

echo "🔧 Building BlueZ..."

# Check basic dependency
if ! pkg-config --exists dbus-1; then
  echo "❌ dbus development libraries not found. Install with: sudo apt install libdbus-1-dev"
  exit 1
fi

./bootstrap
./configure --prefix="$PROJECT_DIR/build"
make -j$(nproc) LDFLAGS="-L/usr/lib/x86_64-linux-gnu"
make install DESTDIR="$PROJECT_DIR/build"

mkdir -p "$OUTPUT_DIR"
cp "$PROJECT_DIR/build/bin/bluetoothd" "$OUTPUT_DIR/bluetoothd" || echo "⚠️ bluetoothd not found"
cp "$PROJECT_DIR/build/tools/hcitool" "$OUTPUT_DIR/hcitool" || echo "⚠️ hcitool not found"
cp "$PROJECT_DIR/build/tools/hcidump" "$OUTPUT_DIR/hcidump" || echo "⚠️ hcidump not found"

echo "✅ Exported BlueZ binaries."
