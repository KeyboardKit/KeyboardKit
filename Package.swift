// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "KeyboardKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "KeyboardKit",
            targets: ["KeyboardKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/MockingKit.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "KeyboardKit",
            dependencies: [],
            resources: [.process("Resources")]),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit", "MockingKit"])
    ]
)
