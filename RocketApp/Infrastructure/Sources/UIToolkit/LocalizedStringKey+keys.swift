import SwiftUI

public extension LocalizedStringKey {
  static let rockets: Self = "rockets".localizedStringKey

  static let overview: Self = "overview".localizedStringKey
  static let parameters: Self = "parameters".localizedStringKey
  static let height: Self = "height".localizedStringKey
  static let diameter: Self = "diameter".localizedStringKey
  static let mass: Self = "mass".localizedStringKey
  static let usMetrics = "us_metrics".localizedStringKey
  static let euMetrics = "eu_metrics".localizedStringKey
  static let firstStage: Self = "first_stage".localizedStringKey
  static let secondStage: Self = "second_stage".localizedStringKey
  static let photos: Self = "photos".localizedStringKey

  static let launch: Self = "launch".localizedStringKey
  static let moveUp: Self = "move_up".localizedStringKey
  static let launchSuccessful: Self = "launch_successful".localizedStringKey

  static func reusable(_ param: Bool) -> Self {
    param ? "reusable".localizedStringKey : "not_reusable".localizedStringKey
  }

  static func engines(_ param: Int) -> Self {
    "engines %lld".localizedStringKey(with: [param])
  }

  static func tonsOfFuel(_ param: Float) -> Self {
    "tons_of_fuel %lf".localizedStringKey(with: [param])
  }

  static func secondsBurnTime(_ param: Int) -> Self {
    "seconds_burn_time %lld".localizedStringKey(with: [param])
  }

  static func firstFlight(_ param: String) -> Self {
    "first_flight %@".localizedStringKey(with: [param])
  }
}
