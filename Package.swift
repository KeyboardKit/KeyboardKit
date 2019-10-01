// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
        .package(url: "git@github.com:Quick/Quick.git", from: "2.2.0"),
        .package(url: "git@github.com:Quick/Nimble.git", .exact("8.0.2")),
        .package(url: "git@github.com:danielsaidi/Mockery.git", from: "0.1.1")
    ],
    targets: [
        .target(
            name: "KeyboardKit",
            dependencies: []),
        .testTarget(
            name: "KeyboardKitTests",
            dependencies: ["KeyboardKit", "Quick", "Nimble", "Mockery"])
    ]
)
