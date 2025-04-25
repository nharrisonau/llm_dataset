#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building lwIP..."

# lwIP doesn't have a standard build system
# We'll just archive the src/core/* as 'samples' for now

mkdir -p "$OUTPUT_DIR"
tar czf "$OUTPUT_DIR/lwip_core.tar.gz" src/core/

echo "✅ Exported lwIP source archive (no direct binary)."
