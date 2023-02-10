// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Infrastructure",
  platforms: [.iOS(.v15), .macOS(.v12)],

  products: [
    .library(
      name: "GeneralToolkit",
      targets: ["GeneralToolkit"]
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
      name: "GeneralToolkit",
      dependencies: [
      ]
    ),
    .testTarget(
      name: "GeneralToolkitTests",
      dependencies: ["GeneralToolkit"]
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
