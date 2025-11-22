// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TcaReducerMixingSample",
    platforms: [
        .iOS(.v17),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "TcaReducerMixingSample",
            targets: ["TcaReducerMixingSample"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "1.0.0"
        ),
    ],
    targets: [
        .target(
            name: "TcaReducerMixingSample",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
    ]
)
