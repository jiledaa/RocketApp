// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v15), .macOS(.v12)],
  // Products define the executables and libraries a package produces, and make them visible to other packages.
  products: [
    .library(
      name: "Root",
      targets: ["Root"]
    ),
    .library(
      name: "RocketDetail",
      targets: ["RocketDetail"]
    ),
    .library(
      name: "RocketLaunch",
      targets: ["RocketLaunch"]
    ),
    .library(
      name: "RocketList",
      targets: ["RocketList"]
    )
  ],

  // Dependencies declare other packages that this package depends on.
  dependencies: [
    .package(path: "../Infrastructure"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.0.0"))
  ],

  // Targets are the basic building blocks of a package. A target can define a module or a test suite.
  // Targets can depend on other targets in this package, and on products in packages this package depends on.
  targets: [
    .target(
      name: "Root",
      dependencies: [
        "RocketList",
        .product(name: "RocketsClient", package: "Infrastructure")
      ]
    ),
    .testTarget(
      name: "RootTests",
      dependencies: ["Root"]
    ),
    .target(
      name: "RocketDetail",
      dependencies: [
        .product(name: "GeneralToolkit", package: "Infrastructure"),
        .product(name: "RocketsClient", package: "Infrastructure"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "RocketDetailTests",
      dependencies: ["RocketDetail"]
    ),
    .target(
      name: "RocketLaunch",
      dependencies: [
        .product(name: "TCAExtensions", package: "Infrastructure"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "RocketLaunchTests",
      dependencies: ["RocketLaunch"]
    ),
    .target(
      name: "RocketList",
      dependencies: [
        "RocketDetail",
        .product(name: "GeneralToolkit", package: "Infrastructure"),
        .product(name: "RocketsClient", package: "Infrastructure"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "RocketListTests",
      dependencies: ["RocketList"]
    )
  ]
)
