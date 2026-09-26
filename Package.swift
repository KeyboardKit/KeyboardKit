// swift-tools-version: 6.2

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
        
        // MARK: - Plugins
        
        .library(
            name: "KeyboardKitAutocompletePlugin",
            targets: ["KeyboardKitAutocompletePlugin"]
        ),
        .library(
            name: "KeyboardKitDictationPlugin",
            targets: ["KeyboardKitDictationPlugin"]
        ),
        .library(
            name: "KeyboardKitHostPlugin",
            targets: ["KeyboardKitHostPlugin"]
        )
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
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0-b.3/KeyboardKit.zip",
            checksum: "998a61a57fbc31a4f81ae3ef4931b1d15f87c7604b9abf75e7a6c448c652aa12"
        ),
        .target(
            name: "KeyboardKitDependencies",
            dependencies: ["LicenseKit"],
            path: "Dependencies",
        ),
        
        // MARK: - Plugins
        
        .binaryTarget(
            name: "KeyboardKitAutocompletePlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0-b.3/KeyboardKitAutocompletePlugin.zip",
            checksum: "d9dd76b5a4b643cfad679d3f04c94789c09ea9698a27b03f0e5fc0d8bc638c0a"
        ),
        .binaryTarget(
            name: "KeyboardKitDictationPlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0-b.3/KeyboardKitDictationPlugin.zip",
            checksum: "41c7dcf5b61e49895b88b929c28a4c24b60b8feb59e28cde543cf6327997464b"
        ),
        .binaryTarget(
            name: "KeyboardKitHostPlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0-b.3/KeyboardKitHostPlugin.zip",
            checksum: "d152d72b561d5332d79b9b4e5ac2cf49206f7b0d06572ca7c838db4eb535de01"
        )
    ]
)
