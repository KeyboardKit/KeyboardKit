// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "KeyboardKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "KeyboardKit",
            targets: ["KeyboardKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.0.0")),
        .package(url: "https://github.com/danielsaidi/MockingKit.git", .upToNextMajor(from: "0.9.0"))
    ],
    targets: [
        .target(
            name: "KeyboardKit",
            dependencies: [],
            exclude: ["Bundle/Bundle+Module.swift"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit", "Quick", "Nimble", "MockingKit"])
    ]
)
