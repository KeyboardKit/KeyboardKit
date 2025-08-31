// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KeyboardKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "KeyboardKit",
            targets: ["KeyboardKit"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "KeyboardKit",
            url: "https://github.com/KeyboardKit/KeyboardKit/releases/download/10.0.0-dp.1-binary/KeyboardKit.zip",
            checksum: "de7f78c7dc4c43216caacbcccca87b50725602d85048be1591c45c651238a8e6"
        )
    ]
)
