// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "GTFS",
    products: [
        .library(
            name: "GTFS",
            targets: ["GTFS"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.8.0"),
    ],
    targets: [
        .target(
            name: "GTFS",
            dependencies: [
                "SwiftProtobuf"
        ]),
        .testTarget(
            name: "GTFSTests",
            dependencies: ["GTFS"]),
    ]
)
