// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftKit",
    products: [
        .library(
            name: "SwiftKit",
            targets: ["SwiftKit"]),
    ],
    targets: [
        .target(
            name: "SwiftKit",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftKitTests",
            dependencies: ["SwiftKit"]
        ),
    ]
)
