import SwiftUI

import UIKit

extension Image {
  init?(nsData: NSData) {
    guard let uiImage = UIImage(data: Data(referencing: nsData)) else {
      return nil
    }

    self = Image(uiImage: uiImage)
  }
}

public extension Image {
  static let burn = Self("Burn", bundle: .module)
  static let engine = Self("Engine", bundle: .module)
  static let fuel = Self("Fuel", bundle: .module)
  static let reusable = Self("Reusable", bundle: .module)
  static let rocketFlying = Self("Rocket Flying", bundle: .module)
  static let rocketIdle = Self("Rocket Idle", bundle: .module)
  static let RocketLaunch = Self("Rocket Launch", bundle: .module)
  static let rocket = Self("Rocket", bundle: .module)
}
