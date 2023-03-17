import Combine
import Foundation

public struct MotionManager {
  public var getMotionData: PassthroughSubject<(width: Double, height: Double), Error>
}
