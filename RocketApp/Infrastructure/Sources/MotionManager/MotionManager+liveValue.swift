import Combine
import CoreMotion
import Dependencies
import Foundation

extension MotionManager: DependencyKey {
  public static var liveValue: Self {
    let accelerationData = PassthroughSubject<CMAccelerometerData, MotionManagerError>()
    let motionManager = CMMotionManager()

    motionManager.startAccelerometerUpdates(
      to: .main,
      withHandler: { motionValue, _ in
        print("cojee epi")
        _ = motionManager
        if let value = motionValue {
          accelerationData.send(value)
        }
      }
    )

    return Self(getMotionData: { accelerationData.eraseToAnyPublisher() })
  }
}
