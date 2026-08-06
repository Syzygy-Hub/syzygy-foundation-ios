// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "syzygy-foundation-ios",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "SyzygyFoundation", targets: ["SyzygyFoundation"]),
        .library(name: "SyzygyFoundationTesting", targets: ["SyzygyFoundationTesting"])
    ],
    targets: [
        .target(name: "SyzygyFoundation", path: "Sources/SyzygyFoundation"),
        .target(
            name: "SyzygyFoundationTesting",
            dependencies: ["SyzygyFoundation"],
            path: "Sources/SyzygyFoundationTesting"
        ),
        .testTarget(
            name: "SyzygyFoundationTests",
            dependencies: ["SyzygyFoundation", "SyzygyFoundationTesting"],
            path: "Tests/SyzygyFoundationTests"
        )
    ]
)
