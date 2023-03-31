import SwiftUI

public extension Image {
  static let burn = Image("burn")
  static let error = Image("error")
  static let engine = Image("engine")
  static let fuel = Image("fuel")
  static let linkArrow = Image("link_arrow")
  static let reusable = Image("reusable")
  static let rocketFlying = Image("rocket_flying")
  static let rocketIdle = Image("rocket_idle")
  static let rocket = Image("rocket")
  static let space = Image("space")
  static let spaceError = Image("space_error")
}

public extension Image {
  init(_ name: String) {
    self.init(name, bundle: .module)
  }
}
