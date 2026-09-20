// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KeyboardKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        // .macOS(.v13),
        // .tvOS(.v16),
        // .watchOS(.v10),
        // .visionOS(.v1)
    ],
    products: [
        .library(
            name: "KeyboardKit",
            targets: ["KeyboardKit", "KeyboardKitDependencies"]
        ),
//        .library(
//            name: "KeyboardKitDictationPlugin",
//            targets: ["KeyboardKitDictationPlugin"]
//        ),
//        .library(
//            name: "KeyboardKitHostPlugin",
//            targets: ["KeyboardKitHostPlugin"]
//        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/LicenseKit/LicenseKit.git",
            exact: "2.2.4"
        )
    ],
    targets: [
        .binaryTarget(
            name: "KeyboardKit",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/10.9.5/KeyboardKit.xcframework.zip",
            checksum: "6b75d935adb10b16f5c5a6ae7e449f0f14126ee1892b911a30ebec5908e48e7f"
        ),
//        .binaryTarget(
//            name: "KeyboardKitDictationPlugin",
//            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0-b.1/KeyboardKitDictationPlugin.zip",
//            checksum: "6aae05ee4ab78c4d04b2ed9548a2c1b73ff201ad661bfd99fd3829086ef0f886"
//        ),
//        .binaryTarget(
//            name: "KeyboardKitHostPlugin",
//            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0-b.1/KeyboardKitHostPlugin.zip",
//            checksum: "7d93ddc13141a470ff3c699e420712ffab4b0f19a3782c00f080f046e2e0edd8"
//        ),
        .target(
            name: "KeyboardKitDependencies",
            dependencies: ["LicenseKit"],
            path: "Dependencies",
        )
    ]
)
