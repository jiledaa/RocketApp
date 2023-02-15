import Dependencies
import Foundation

enum RocketsClientKey: DependencyKey {
  public static var liveValue: RocketsClient = .liveValue
  #if DEBUG
  public static var testValue: RocketsClient = .testValue
  #endif
  public static var previewValue: RocketsClient = .previewValue
}

public extension DependencyValues {
  var rocketsClient: RocketsClient {
    get { self[RocketsClientKey.self] }
    set { self[RocketsClientKey.self] = newValue }
  }
}