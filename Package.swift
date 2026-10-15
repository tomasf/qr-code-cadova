// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "model",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/tomasf/Cadova.git", branch: "dev"),
        .package(url: "https://github.com/CorvidLabs/swift-qr.git", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "model",
            dependencies: [
                "Cadova",
                .product(name: "SwiftQR", package: "swift-qr"),
            ],
            exclude: ["Resources/Nunito-OFL.txt"],
            resources: [.copy("Resources/Nunito.ttf")],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
    ]
)
