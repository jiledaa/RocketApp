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

enum LineMeasureConverterKey: DependencyKey {
  static let liveValue: LineMeasureConverter = .live
  #if DEBUG
  static let testValue: LineMeasureConverter = .test
  #endif
}

public extension DependencyValues {
  var lineMeasureConverter: LineMeasureConverter {
    get { self[LineMeasureConverterKey.self] }
    set { self[LineMeasureConverterKey.self] = newValue }
  }
}

enum WeightScaleConverterKey: DependencyKey {
  static let liveValue: WeightScaleConverter = .live
  #if DEBUG
  static let testValue: WeightScaleConverter = .test
  #endif
}

public extension DependencyValues {
  var weightScaleConverter: WeightScaleConverter {
    get { self[WeightScaleConverterKey.self] }
    set { self[WeightScaleConverterKey.self] = newValue }
  }
}

enum StageConverterKey: DependencyKey {
  static let liveValue: StageConverter = .live
  #if DEBUG
  static let testValue: StageConverter = .test
  #endif
}

public extension DependencyValues {
  var stageConverter: StageConverter {
    get { self[StageConverterKey.self] }
    set { self[StageConverterKey.self] = newValue }
  }
}
