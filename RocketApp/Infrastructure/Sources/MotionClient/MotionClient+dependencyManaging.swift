import Dependencies
import Foundation

enum MotionClientKey: DependencyKey {
  public static var liveValue: MotionClient = .liveValue
  #if DEBUG
  public static var testValue: MotionClient = .testValue
  #endif
}

public extension DependencyValues {
  var motionClient: MotionClient {
    get { self[MotionClientKey.self] }
    set { self[MotionClientKey.self] = newValue }
  }
}
