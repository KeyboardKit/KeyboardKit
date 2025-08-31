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
    dependencies: [],
    targets: [
        .target(
            name: "KeyboardKit",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit"]
        )
    ]
)
