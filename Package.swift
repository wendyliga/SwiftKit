// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftKit",
    products: [
        .library(
            name: "SwiftKit",
            targets: ["SwiftKit"]),
        .library(
            name: "ShellKit",
            targets: ["ShellKit"]),
    ],
    targets: [
        .target(
            name: "SwiftKit",
            dependencies: []
        ),
        .target(
            name: "ShellKit",
            dependencies: ["SwiftKit"]
        ),
        .testTarget(
            name: "SwiftKitTests",
            dependencies: ["SwiftKit"]
        ),
    ]
)
