import Dependencies
import Foundation
import ModelConvertible

enum RocketConverterKey: DependencyKey {
  static let liveValue: RocketConverter = .live
  #if DEBUG
  static let testValue: RocketConverter = .test
  #endif
}

public extension DependencyValues {
  var rocketConverter: RocketConverter {
    get { self[RocketConverterKey.self] }
    set { self[RocketConverterKey.self] = newValue }
  }
}

enum RocketsConverterKey: DependencyKey {
  static let liveValue: RocketsConverter = .live
  #if DEBUG
  static let testValue: RocketsConverter = .test
  #endif
}

public extension DependencyValues {
  var rocketsConverter: RocketsConverter {
    get { self[RocketsConverterKey.self] }
    set { self[RocketsConverterKey.self] = newValue }
  }
}
