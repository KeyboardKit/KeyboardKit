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
            targets: ["KeyboardKit", "KeyboardKitDependencies"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/LicenseKit/LicenseKit.git",
            exact: "2.1.3"
        )
    ],
    targets: [
        .binaryTarget(
            name: "KeyboardKit",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/10.4.1/KeyboardKit.zip",
            checksum: "f15cb0451d47c06a928b15974d70e3f5ae1e1d9f1c4f65aa35a865a52fb15d08"
        ),
        .target(
            name: "KeyboardKitDependencies",
            dependencies: ["LicenseKit"],
            path: "Dependencies",
        )
    ]
)
