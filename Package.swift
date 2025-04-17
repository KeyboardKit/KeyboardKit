// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KeyboardKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "KeyboardKit",
            targets: ["KeyboardKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/danielsaidi/MockingKit.git",
            .upToNextMajor(from: "1.5.0")
        )
    ],
    targets: [
        .target(
            name: "KeyboardKit",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit", "MockingKit"]
        )
    ]
)
