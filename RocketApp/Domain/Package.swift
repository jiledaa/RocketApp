// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Domain",
  platforms: [.iOS(.v15), .macOS(.v12)],

  products: [
    .library(
      name: "RocketsClient",
      targets: ["RocketsClient"]
    )
  ],

  dependencies: [
    .package(path: "../Infrastructure"),
    .package(url: "https://github.com/Qase/swift-core", branch: "develop"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.1.4"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.3.2")
  ],

  targets: [
    .target(
      name: "RocketsClient",
      dependencies: [
        .product(name: "NetworkClientExtensions", package: "Infrastructure"),
        .product(name: "Networking", package: "swift-core"),
        .product(name: "RequestBuilder", package: "swift-core"),
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay")
      ]
    ),
    .testTarget(
      name: "RocketsClientTests",
      dependencies: [
        "RocketsClient"
      ]
    )
  ]
)
