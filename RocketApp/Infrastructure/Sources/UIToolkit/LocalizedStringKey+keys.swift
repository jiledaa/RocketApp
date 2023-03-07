import SwiftUI

public extension LocalizedStringKey {
  static let rockets: Self = "rockets".localizedStringKey

  static let overview: Self = "overview".localizedStringKey
  static let parameters: Self = "parameters".localizedStringKey
  static let height: Self = "height".localizedStringKey
  static let diameter: Self = "diameter".localizedStringKey
  static let mass: Self = "mass".localizedStringKey
  static let firstStage: Self = "first.stage".localizedStringKey
  static let secondStage: Self = "second.stage".localizedStringKey
  static let photos: Self = "photos".localizedStringKey

  static let launch: Self = "launch".localizedStringKey
  static let moveUp: Self = "move.up".localizedStringKey
  static let launchSuccessful: Self = "launch.successful".localizedStringKey

  static func firstFlight(_ param: String) -> Self {
    "first.flight".localizedStringKey(with: [param])
  }
}
