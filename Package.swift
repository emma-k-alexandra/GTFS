// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "GTFS",
    products: [
        .library(
            name: "GTFS",
            targets: ["GTFS"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            name: "SwiftProtobuf",
            url: "https://github.com/apple/swift-protobuf.git",
            .upToNextMajor(from: .init(1, 18, 0))
        )
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
