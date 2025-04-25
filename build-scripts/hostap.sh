#!/bin/bash
set -e
set -x

PROJECT_DIR=$(pwd)
ROOT_DIR=$(realpath "$PROJECT_DIR/../../..")
OUTPUT_DIR="$ROOT_DIR/samples/original"

echo "🔧 Building hostap (wpa_supplicant + hostapd)..."

# Check libnl
if ! pkg-config --exists libnl-3.0; then
  echo "❌ libnl-3-dev and libnl-genl-3-dev missing. Install with: sudo apt install libnl-3-dev libnl-genl-3-dev"
  exit 1
fi

# Build wpa_supplicant
pushd wpa_supplicant > /dev/null
cp defconfig .config
make clean
make -j"$(nproc)" LDFLAGS="-L/usr/lib/x86_64-linux-gnu"
cp wpa_supplicant "$OUTPUT_DIR/wpa_supplicant" || echo "⚠️ wpa_supplicant not built"
popd > /dev/null

# Build hostapd
pushd hostapd > /dev/null
cp defconfig .config
make clean
make -j"$(nproc)" LDFLAGS="-L/usr/lib/x86_64-linux-gnu"
cp hostapd "$OUTPUT_DIR/hostapd" || echo "⚠️ hostapd not built"
popd > /dev/null

echo "✅ Exported wpa_supplicant and hostapd binaries."