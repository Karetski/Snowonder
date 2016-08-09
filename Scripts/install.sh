#!/bin/sh

VERSION=0.1.0
# https://github.com/Karetski/Snowonder/releases/download/0.1.0/Snowonder-0.1.0.zip
DOWNLOAD_URI=https://github.com/Karetski/Snowonder/releases/download/${VERSION}/Snowonder-${VERSION}.zip
PLUGINS_DIR="${HOME}/Library/Application Support/Developer/Shared/Xcode/Plug-ins"
XCODE_VERSION="$(xcrun xcodebuild -version | head -n1 | awk '{ print $2 }')"
TEMP_FNAME=snwndr.zip

mkdir -p "${PLUGINS_DIR}"
cd "${PLUGINS_DIR}"
curl -L $DOWNLOAD_URI -o $TEMP_FNAME
unzip -o $TEMP_FNAME
rm -rf $TEMP_FNAME

echo "🚀 Snowonder ${VERSION} is successfully installed! Please restart your Xcode ${XCODE_VERSION}."