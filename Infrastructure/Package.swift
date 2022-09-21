// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [.iOS(.v15), .macOS(.v12)],
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    products: [
        .library(
            name: "CoreToolkit",
            targets: ["CoreToolkit"]
        ),

        .library(
            name: "Networking",
            targets: ["Networking"]
        ),

        .library(
            name: "RocketModels",
            targets: ["RocketModels"]
        ),

        .library(
            name: "TCAExtensions",
            targets: ["TCAExtensions"]
        ),

        .library(
            name: "UIToolkit",
            targets: ["UIToolkit"]
        ),
    ],

    // Dependencies declare other packages that this package depends on.
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.0.0")),
    ],

    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    targets: [
        .target(
            name: "CoreToolkit",
            dependencies: [
                "Networking"
            ]
        ),
        .testTarget(
            name: "CoreToolkitTests",
            dependencies: ["CoreToolkit"]
        ),

        .target(
            name: "Networking",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),

        .target(
            name: "RocketModels",
            dependencies: [
                "Networking",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "RocketModelsTests",
            dependencies: ["RocketModels"]
        ),

        .target(
            name: "TCAExtensions",
            dependencies: [
                "Networking",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "TCAExtensionsTests",
            dependencies: ["TCAExtensions"]
        ),

        .target(
            name: "UIToolkit",
            dependencies: [
                "Networking"
            ]
        ),
        .testTarget(
            name: "UIToolkitTests",
            dependencies: ["UIToolkit"]
        ),
    ]
)
