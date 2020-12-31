// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "KeyboardKit",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "KeyboardKit",
            targets: ["KeyboardKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.0.0")),
        .package(url: "https://github.com/danielsaidi/MockingKit.git", .upToNextMajor(from: "0.8.0"))
    ],
    targets: [
        .target(
            name: "KeyboardKit",
            dependencies: []),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit", "Quick", "Nimble", "MockingKit"])
    ]
)
