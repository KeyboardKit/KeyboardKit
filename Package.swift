// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "KeyboardKit-LearnAI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "KeyboardKit-LearnAI",
            targets: ["KeyboardKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/danielsaidi/MockingKit.git",
            .upToNextMajor(from: "1.3.0")
        )
    ],
    targets: [
        .target(
            name: "KeyboardKit",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit", "MockingKit"]
        )
    ]
)
    
