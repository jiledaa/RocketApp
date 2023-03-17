import Foundation

public enum MotionManagerError: Error, Equatable {
  case motionError

  public init(motionError: Error) {
      self = .motionError
  }
}
