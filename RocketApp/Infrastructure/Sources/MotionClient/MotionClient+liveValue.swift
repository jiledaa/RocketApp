import Combine
import ComposableCoreMotion
import Dependencies
import Foundation

extension MotionClient: DependencyKey {
  public static var liveValue = Self(motionClient: MotionManager.live)
}
