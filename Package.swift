// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "model",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/tomasf/Cadova.git", .upToNextMinor(from: "0.6.0")),
        .package(url: "https://github.com/CorvidLabs/swift-qr.git", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "model",
            dependencies: [
                "Cadova",
                .product(name: "SwiftQR", package: "swift-qr"),
            ],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
    ]
)
