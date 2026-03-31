#!/bin/bash
set -e

# --- Aired Artifact — Publish to aired.sh ---
# Publishes bundle.html to a shareable URL.

BUNDLE="${1:-bundle.html}"

if [ ! -f "$BUNDLE" ]; then
  echo "Error: $BUNDLE not found. Run bundle-artifact.sh first."
  exit 1
fi

# Check if aired is available
if command -v aired &> /dev/null; then
  aired "$BUNDLE" --json
elif command -v npx &> /dev/null; then
  npx aired "$BUNDLE" --json
else
  echo "Error: aired CLI not found. Install with: npm install -g aired"
  exit 1
fi
