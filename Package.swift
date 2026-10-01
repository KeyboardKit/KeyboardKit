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
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0.0/KeyboardKit.zip",
            checksum: "6b22f2cfa7acaf771b9447d8a529a13783ee02cdf4ae1fd73e5ded170126b624"
        ),
        .target(
            name: "KeyboardKitDependencies",
            dependencies: ["LicenseKit"],
            path: "Dependencies",
        ),
        
        // MARK: - Plugins
        
        .binaryTarget(
            name: "KeyboardKitAutocompletePlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0.0/KeyboardKitAutocompletePlugin.zip",
            checksum: "656d4f1b1409413679aa733a941f9913772dba2bab22726bcc00d00f6b1f4bc2"
        ),
        .binaryTarget(
            name: "KeyboardKitDictationPlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0.0/KeyboardKitDictationPlugin.zip",
            checksum: "ed5cf5407f39bd60a2b28635414b7a02a122337c46c2ef6d9cd32c771c7d16cf"
        ),
        .binaryTarget(
            name: "KeyboardKitHostPlugin",
            url: "https://github.com/KeyboardKit/KeyboardKit-Binaries/releases/download/11.0.0/KeyboardKitHostPlugin.zip",
            checksum: "a9c804c9bb5811318d812b3a63ebd91a9709e864f15b85b976be34016c078ac8"
        )
    ]
)
