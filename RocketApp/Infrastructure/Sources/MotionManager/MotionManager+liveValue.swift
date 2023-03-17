import Combine
import Dependencies
import Foundation

extension MotionManager: DependencyKey {
  public static var liveValue = Self(getMotionData: PassthroughSubject<(width: Double, height: Double), Error>())
}
