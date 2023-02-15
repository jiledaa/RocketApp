// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v15), .macOS(.v12)],

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
    ),
    .library(
      name: "RocketListCell",
      targets: ["RocketListCell"]
    )
  ],

  dependencies: [
    .package(path: "../Domain"),
    .package(path: "../Infrastructure"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.5.0"))
  ],

  targets: [
    .target(
      name: "Root",
      dependencies: [
        "RocketList",
        .product(name: "RocketsClient", package: "Domain")
      ]
    ),
    .testTarget(
      name: "RootTests",
      dependencies: ["Root"]
    ),
    .target(
      name: "RocketDetail",
      dependencies: [
        .product(name: "CoreToolkit", package: "Infrastructure"),
        .product(name: "RocketsClient", package: "Domain"),
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
        .product(name: "RocketsClient", package: "Domain"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "RocketListTests",
      dependencies: ["RocketList"]
    ),
    .target(
      name: "RocketListCell",
      dependencies: [
        .product(name: "RocketsClient", package: "Domain"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "RocketListCellTests",
      dependencies: ["RocketListCell"]
    )
  ]
)
