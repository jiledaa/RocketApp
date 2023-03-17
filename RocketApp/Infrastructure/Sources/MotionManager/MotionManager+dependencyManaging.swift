import Dependencies
import Foundation

enum MotionManagerKey: DependencyKey {
  public static var liveValue: MotionManager = .liveValue
  #if DEBUG
  public static var testValue: MotionManager = .testValue
  #endif
}

public extension DependencyValues {
  var motionManager: MotionManager {
    get { self[MotionManagerKey.self] }
    set { self[MotionManagerKey.self] = newValue }
  }
}
