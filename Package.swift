// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "KeyboardKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "KeyboardKit",
            targets: ["KeyboardKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/MockingKit.git", .upToNextMajor(from: "1.3.0"))
    ],
    targets: [
        .target(
            name: "KeyboardKit",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit", "MockingKit"])
    ]
)
