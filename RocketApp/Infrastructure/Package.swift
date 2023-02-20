// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Infrastructure",
  platforms: [.iOS(.v15), .macOS(.v12)],

  products: [
    .library(
      name: "CoreToolkit",
      type: .static,
      targets: ["CoreToolkit"]
    ),
    .library(
      name: "DispatchQueueExtensions",
      targets: ["DispatchQueueExtensions"]
    ),
    .library(
      name: "NetworkClientExtensions",
      targets: ["NetworkClientExtensions"]
    ),
    .library(
      name: "TCAExtensions",
      targets: ["TCAExtensions"]
    ),
    .library(
      name: "UIToolkit",
      targets: ["UIToolkit"]
    )
  ],

  dependencies: [
    .package(url: "https://github.com/Qase/swift-core", branch: "develop"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.1.4"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.5.0")),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.3.2"),
    .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "0.9.1")
  ],

  targets: [
    .target(
      name: "CoreToolkit",
      dependencies: [
      ]
    ),
    .testTarget(
      name: "CoreToolkitTests",
      dependencies: ["CoreToolkit"]
    ),
    .target(
      name: "DispatchQueueExtensions",
      dependencies: [
        .product(name: "CombineSchedulers", package: "combine-schedulers"),
        .product(name: "Dependencies", package: "swift-dependencies")
      ]
    ),
    .target(
      name: "NetworkClientExtensions",
      dependencies: [
        .product(name: "Networking", package: "swift-core"),
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay")
      ]
    ),
    .target(
      name: "TCAExtensions",
      dependencies: [
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
      ]
    ),
    .testTarget(
      name: "UIToolkitTests",
      dependencies: ["UIToolkit"]
    )
  ]
)
