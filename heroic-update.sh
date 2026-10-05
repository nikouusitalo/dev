#!/usr/bin/env bash

set -euo pipefail

REPO="Heroic-Games-Launcher/HeroicGamesLauncher"
API_URL="https://api.github.com/repos/$REPO/releases/latest"

echo "Tarkistetaan uusin Heroic-versio..."

# Hae uusimman x86_64 RPM-paketin URL GitHubista
RPM_URL="$(
    curl -fsSL "$API_URL" |
    python3 -c '
import json
import sys

release = json.load(sys.stdin)

for asset in release["assets"]:
    name = asset["name"]

    if name.endswith("-linux-x86_64.rpm"):
        print(asset["browser_download_url"])
        break
else:
    sys.exit("RPM-pakettia ei löytynyt releasesta.")
'
)"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

RPM_FILE="$TMP_DIR/heroic.rpm"

echo "Ladataan:"
echo "$RPM_URL"

curl -fL "$RPM_URL" -o "$RPM_FILE"

# Luetaan tiedot suoraan ladatusta RPM-paketista
PACKAGE_NAME="$(rpm -qp --queryformat '%{NAME}' "$RPM_FILE")"
NEW_VERSION="$(rpm -qp --queryformat '%{VERSION}-%{RELEASE}' "$RPM_FILE")"

echo
echo "Uusin versio: $NEW_VERSION"

if rpm -q "$PACKAGE_NAME" >/dev/null 2>&1; then
    CURRENT_VERSION="$(rpm -q --queryformat '%{VERSION}-%{RELEASE}' "$PACKAGE_NAME")"

    echo "Asennettu versio: $CURRENT_VERSION"

    if [[ "$CURRENT_VERSION" == "$NEW_VERSION" ]]; then
        echo "Heroic on jo ajan tasalla."
        exit 0
    fi
else
    echo "Heroicia ei ole vielä asennettu."
fi

echo
echo "Asennetaan/päivitetään Heroic..."

sudo dnf install -y "$RPM_FILE"

echo
echo "Valmis."
