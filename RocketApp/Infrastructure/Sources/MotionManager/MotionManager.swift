import Combine
import CoreMotion
import Foundation

public struct MotionManager {
  public var getMotionData: () -> AnyPublisher<CMAccelerometerData, MotionManagerError>
}
