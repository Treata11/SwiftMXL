// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftMXL",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftMXL",
            targets: ["SwiftMXL"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/MaxDesiatov/XMLCoder", from: "0.17.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6"),
    ],
    targets: [
        .target(
            name: "SwiftMXL",
            dependencies: ["XMLCoder"]
        ),
        .testTarget(
            name: "SwiftMXLTests",
            dependencies: ["SwiftMXL", "Yams"]
        ),
    ]
)
