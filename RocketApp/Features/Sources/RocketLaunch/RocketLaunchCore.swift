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
    var width: Double = 0
    var height: Double = 800

    public init(rocketData: RocketDetail) {
      self.rocketData = rocketData
    }
  }

  public enum Action: Equatable {
    case launch
    case drop
    case onAppear
    case updateMotionData(Result<CMAccelerometerData, MotionManagerError>)
    case onDisappear
  }

  public init() {}

  @Dependency(\.motionManager) var motionManager
  @Dependency(\.mainQueue) var mainQueue

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      enum MotionDataKey: Hashable {}

      switch action {
      case .launch:
        return .none

      case .drop:
        return .none

      case .onAppear:
        return motionManager.getMotionData()
          .receive(on: mainQueue)
          .catchToEffect(RocketLaunchCore.Action.updateMotionData)
          .cancellable(id: MotionDataKey.self, cancelInFlight: true)

      case let .updateMotionData(.success(motionData)):
        state.width = CGVector(dx: 0 + motionData.acceleration.x * 50, dy: 0).dx
        state.height = CGVector(dx: 0, dy: 800 - motionData.acceleration.y * 50).dy
        print("cojee \(state.height)")

        return .none

      case let .updateMotionData(.failure(motionError)):

        return .none

      case .onDisappear:
        return Effect.cancel(id: MotionDataKey.self)
      }
    }
  }
}
