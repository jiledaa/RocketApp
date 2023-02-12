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
      name: "TCAExtensions",
      targets: ["TCAExtensions"]
    ),
    .library(
      name: "UIToolkit",
      targets: ["UIToolkit"]
    )
  ],

  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.0.0"))
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
