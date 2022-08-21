// swift-tools-version:5.5

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
        .package(url: "https://github.com/danielsaidi/Quick.git", .branch("main")), // .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/danielsaidi/Nimble.git", .branch("main")), // .upToNextMajor(from: "9.0.0")),
        .package(url: "https://github.com/danielsaidi/MockingKit.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "KeyboardKit",
            dependencies: [],
            resources: [.process("Resources")]),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit", "Quick", "Nimble", "MockingKit"])
    ]
)
