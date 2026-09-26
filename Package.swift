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
            checksum: "8cc7bc57b568443387b3db613598ad5de945f78b4e81f8bd44bbe25fee127230"
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
            checksum: "55f774d7d4e8734a48fab2d6fa4067d82cab17817f652a474ce6f145d6a3c2eb"
        ),
        .binaryTarget(
            name: "KeyboardKitDictationPlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0-b.3/KeyboardKitDictationPlugin.zip",
            checksum: "d5ae44d3f1530e167eb9f18ac1d9f7a5d5cc4271bc09207991b29e7de7484be0"
        ),
        .binaryTarget(
            name: "KeyboardKitHostPlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0-b.3/KeyboardKitHostPlugin.zip",
            checksum: "050e335a69d1416d2d5e94de5824972954abebaa399894f982270dbbd7cd8ac8"
        )
    ]
)
