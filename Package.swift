// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "model",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/tomasf/Cadova.git", from: "1.1.0"),
        .package(url: "https://github.com/CorvidLabs/swift-qr.git", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "model",
            dependencies: [
                "Cadova",
                .product(name: "SwiftQR", package: "swift-qr"),
            ],
            exclude: ["Resources/Fredoka-OFL.txt"],
            resources: [.copy("Resources/Fredoka.ttf")],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
    ]
)
