// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Infrastructure",
  platforms: [.iOS(.v15), .macOS(.v12)],
  // Products define the executables and libraries a package produces, and make them visible to other packages.
  products: [
    .library(
      name: "GeneralToolkit",
      targets: ["GeneralToolkit"]
    ),

      .library(
        name: "RocketsClient",
        targets: ["RocketsClient"]
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

  // Dependencies declare other packages that this package depends on.
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.0.0")),
    .package(url: "https://github.com/Qase/swift-core", branch: "develop")
  ],

  // Targets are the basic building blocks of a package. A target can define a module or a test suite.
  // Targets can depend on other targets in this package, and on products in packages this package depends on.
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
        name: "RocketsClient",
        dependencies: [
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
        ]
      ),
    .testTarget(
      name: "RocketsClientTests",
      dependencies: ["RocketsClient"]
    ),

      .target(
        name: "TCAExtensions",
        dependencies: [
          "RocketsClient",
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
          "RocketsClient"
        ]
      ),
    .testTarget(
      name: "UIToolkitTests",
      dependencies: ["UIToolkit"]
    )
  ]
)
