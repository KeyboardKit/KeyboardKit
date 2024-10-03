#!/bin/bash

swift package resolve;
          
xcodebuild docbuild -scheme KeyboardKit -derivedDataPath /tmp/docbuild -destination 'generic/platform=iOS';

$(xcrun --find docc) process-archive \
transform-for-static-hosting /tmp/docbuild/Build/Products/Debug-iphoneos/KeyboardKit.doccarchive \
--output-path docs \
--hosting-base-path 'KeyboardKit';