import Dependencies
import Foundation

enum RocketsClientAsyncKey: DependencyKey {
  public static let liveValue: RocketsClientAsync = .live
  #if DEBUG
  public static let testValue: RocketsClientAsync = .test
  #endif
  public static let previewValue: RocketsClientAsync = .preview
}

public extension DependencyValues {
  var rocketsClientAsync: RocketsClientAsync {
    get { self[RocketsClientAsyncKey.self] }
    set { self[RocketsClientAsyncKey.self] = newValue }
  }
}
