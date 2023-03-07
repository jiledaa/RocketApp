import SwiftUI

public extension Image {
  static let burn = Image("Burn")
  static let engine = Image("Engine")
  static let fuel = Image("Fuel")
  static let linkArrow = Image("Link Arrow")
  static let reusable = Image("Reusable")
  static let rocketFlying = Image("Rocket Flying")
  static let rocketIdle = Image("Rocket Idle")
  static let rocket = Image("Rocket")
}

public extension Image {
  init(_ name: String) {
    self.init(name, bundle: .module)
  }
}
