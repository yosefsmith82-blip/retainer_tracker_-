#!/usr/bin/env bash
# Copies the web app into www/ for Capacitor to wrap.
#
# The app itself lives at the repository root so GitHub Pages can serve it
# straight from main. Capacitor needs its own folder, so this mirrors the
# handful of files it needs — rather than pointing webDir at the root, which
# would sweep node_modules and the native projects into the app bundle.
set -euo pipefail

cd "$(dirname "$0")/.."
rm -rf www
mkdir -p www

cp index.html privacy.html manifest.webmanifest www/
cp icon-192.png icon-512.png icon-maskable.png www/

# The service worker exists to make the *website* work offline. A native app is
# already offline, and registering it against capacitor://localhost only risks
# serving stale files after an update, so it is deliberately left out of www/.

echo "www/ built:"
ls -1 www
