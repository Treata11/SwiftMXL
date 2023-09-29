// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if swift(>=5.7)
let platforms: [PackageDescription.SupportedPlatform] = [.macOS(.v10_14), .iOS(.v11), .watchOS(.v4), .tvOS(.v11)]
#elseif swift(>=5.0)
let platforms: [PackageDescription.SupportedPlatform]? = nil
#endif

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
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
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
