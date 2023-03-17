import ComposableArchitecture
import CoreMotion
import Foundation
import MotionManager
import RocketsClient

public struct RocketLaunchCore: ReducerProtocol {
  public struct State: Equatable {
    public var rocketData: RocketDetail

    var rocketHasLaunched: Bool = false
    var rocketPosition = CGPoint(x: 0, y: 0)
    var motionManager: CMMotionManager?
    var width: Double = 0
    var height: Double = 0

    public init(rocketData: RocketDetail) {
      self.rocketData = rocketData
    }
  }

  public enum Action: Equatable {
    case launch
    case drop
    case onAppear
  }

  public init() {}

  @Dependency(\.motionManager) var motionManager

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .launch:
        return .none

      case .drop:
        return .none

      case .onAppear:
        state.motionManager = CMMotionManager()
        state.motionManager?.gyroUpdateInterval = 1
        state.motionManager?.accelerometerUpdateInterval = 1
        state.motionManager?.startAccelerometerUpdates(
          to: .main,
          withHandler: { value, _ in
            if let value = value {
              print("cojee epir \(value.acceleration.x)")
            }
          }
        )

        return .none

//      case let .onChange(value):
//        if let value = value {
//          state.height = CGVector(dx: 0, dy: 800 - value.rotationRate.y).dy
//          state.width = CGVector(dx: 0 + value.rotationRate.x * 10000, dy: 0).dx
//        }
//
//        return .none
      }
    }
  }
}
