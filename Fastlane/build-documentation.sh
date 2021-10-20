#!/bin/sh

rm -rf Docs
mkdir -p Docs

xcodebuild docbuild \
    -scheme KeyboardKit \
    -destination generic/platform=iOS \

echo "Copying documentation archive..."

find ~/Library/Developer/Xcode/DerivedData \
    -name "KeyboardKit.doccarchive" \
    -exec cp -R {} Docs \;

cd Docs

echo "Compressing documentation archive..."

zip -r \
    KeyboardKit.doccarchive.zip \
    KeyboardKit.doccarchive

rm -rf KeyboardKit.doccarchive

cd ..
