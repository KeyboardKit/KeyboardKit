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
            exact: "2.3.0"
        )
    ],
    targets: [
        .binaryTarget(
            name: "KeyboardKit",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.1.1/KeyboardKit.zip",
            checksum: "e0521472c1871addc81f0bd2d066b9e89ee1844fbcf719b8604959c065d791a9"
        ),
        .target(
            name: "KeyboardKitDependencies",
            dependencies: ["LicenseKit"],
            path: "Dependencies",
        ),
        
        // MARK: - Plugins
        
        .binaryTarget(
            name: "KeyboardKitAutocompletePlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.1.0/KeyboardKitAutocompletePlugin.zip",
            checksum: "213282148e63b8df397233ca690fcd34380970cd8a9f511e5c66de3d8a18d426"
        ),
        .binaryTarget(
            name: "KeyboardKitDictationPlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0.1/KeyboardKitDictationPlugin.zip",
            checksum: "41741ba0fe65aa0c481a94967e9aebe92a1b56e911dc82ccaea6e569738cd9c1"
        ),
        .binaryTarget(
            name: "KeyboardKitHostPlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0.0/KeyboardKitHostPlugin.zip",
            checksum: "a9c804c9bb5811318d812b3a63ebd91a9709e864f15b85b976be34016c078ac8"
        )
    ]
)
