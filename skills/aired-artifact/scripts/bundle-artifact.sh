#!/bin/bash
set -e

# --- Aired Artifact — Bundle to Single HTML ---
# Builds the React app and inlines all assets into one shareable HTML file.
# Run from the project root (where package.json is).

if [ ! -f "package.json" ]; then
  echo "Error: No package.json found. Run this from your project root."
  exit 1
fi

if [ ! -f "index.html" ]; then
  echo "Error: No index.html found in project root."
  exit 1
fi

# Install bundling deps if not present
if ! npm ls parcel > /dev/null 2>&1; then
  echo "Installing bundling dependencies..."
  npm install -D parcel @parcel/config-default parcel-resolver-tspaths html-inline
fi

# Create Parcel config with path alias support
if [ ! -f ".parcelrc" ]; then
  cat > .parcelrc << 'EOF'
{
  "extends": "@parcel/config-default",
  "resolvers": ["parcel-resolver-tspaths", "..."]
}
EOF
fi

# Clean previous build
rm -rf dist-parcel .parcel-cache bundle.html

# Build with Parcel
echo "Building..."
npx parcel build index.html --no-source-maps --dist-dir dist-parcel

# html-inline chokes on external URLs (https://...).
# Strategy: strip external links, inline local assets, re-inject via Node.
BUILT_HTML="dist-parcel/index.html"

# Save external link tags to temp file
grep -o '<link[^>]*href="*https[^>]*>' "$BUILT_HTML" > /tmp/_aired_ext.txt 2>/dev/null || true
grep -o '<link[^>]*href=https[^>]*>' "$BUILT_HTML" >> /tmp/_aired_ext.txt 2>/dev/null || true

# Remove external links from Parcel output
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' 's/<link[^>]*href="*https[^>]*>//g' "$BUILT_HTML"
else
  sed -i 's/<link[^>]*href="*https[^>]*>//g' "$BUILT_HTML"
fi

# Inline all local assets
echo "Inlining assets..."
npx html-inline -i "$BUILT_HTML" -o bundle.html -b dist-parcel

# Post-process: inject charset + external links via Node
# Charset MUST be within first 1024 bytes or Unicode (emoji, symbols) breaks.
node -e "
  const fs = require('fs');
  let html = fs.readFileSync('bundle.html', 'utf8');

  // Read external links if saved
  let links = '';
  try { links = fs.readFileSync('/tmp/_aired_ext.txt', 'utf8').trim().split('\n').filter(Boolean).join(' '); } catch {}

  // Ensure <meta charset> is the very first thing after <!DOCTYPE html>
  const charset = '<meta charset=\"UTF-8\">';
  const inject = charset + ' ' + links;

  if (html.includes('<head>')) {
    html = html.replace('<head>', '<head>' + inject);
  } else if (html.includes('<html')) {
    html = html.replace(/<html([^>]*)>/, '<html\$1><head>' + inject + '</head>');
  } else {
    // Fallback: prepend to document
    html = '<!DOCTYPE html><html><head>' + inject + '</head>' + html;
  }

  fs.writeFileSync('bundle.html', html);
"

# Clean up
rm -rf dist-parcel .parcel-cache /tmp/_aired_ext.txt

# Report
SIZE=$(ls -lh bundle.html | awk '{print $5}')
echo ""
echo "Done: bundle.html ($SIZE)"
echo ""
echo "Next: aired bundle.html"
