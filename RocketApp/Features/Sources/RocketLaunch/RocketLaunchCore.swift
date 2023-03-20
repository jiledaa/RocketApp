import ComposableArchitecture
import ComposableCoreMotion
import Foundation
import MotionClient
import RocketsClient

public struct RocketLaunchCore: ReducerProtocol {
  public struct State: Equatable {
    public var rocketData: RocketDetail

    var rocketHasLaunched: Bool = false
    var potentialHeight: Double?
    var initialHeight: Double {
      potentialHeight ?? 0
    }
    var rWidth: Double = 0
    var lWidth: Double = 0
    var height: Double = 0
    var roll: Double = 0
    var pitch: Double = 0
    var motionError: NSError?

    public init(rocketData: RocketDetail, rocketHasLaunched: Bool = false) {
      self.rocketData = rocketData
      self.rocketHasLaunched = rocketHasLaunched
    }
  }

  public enum Action: Equatable {
    case onAppear
    case updateMotionData(Result<DeviceMotion, NSError>)
    case onDisappear
  }

  public init() {}

  @Dependency(\.motionClient) var motionManager

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      struct MotionManagerId: Hashable {}

      switch action {
      case .onAppear:
        return .concatenate(
          motionManager.motionClient
            .create(id: MotionManagerId())
            .fireAndForget(),

          motionManager.motionClient
            .startDeviceMotionUpdates(id: MotionManagerId(), using: .xArbitraryZVertical, to: .main)
            .mapError { $0 as NSError }
            .catchToEffect(RocketLaunchCore.Action.updateMotionData)
        )

      case let .updateMotionData(.success(motionData)):
        if state.potentialHeight == nil {
          state.potentialHeight = motionData.attitude.quaternion.x
        }
        let magnitude: Double = 800
        let width = motionData.attitude.quaternion.y * magnitude
        let height = (abs(state.initialHeight) - abs(motionData.attitude.quaternion.x)) * magnitude

        state.lWidth = width < 0 && state.rocketHasLaunched ? abs(width) : 0
        state.rWidth = width > 0 && state.rocketHasLaunched ? width : 0
        state.height = height > 50 ? height : 0
        state.rocketHasLaunched = state.height != 0

        state.pitch = motionData.attitude.pitch
        state.roll = motionData.attitude.roll
        return .none

      case let .updateMotionData(.failure(motionError)):
        state.motionError = motionError
        return .none

      case .onDisappear:
        return .concatenate(
          motionManager.motionClient
            .stopDeviceMotionUpdates(id: MotionManagerId())
            .fireAndForget(),

          motionManager.motionClient
            .destroy(id: MotionManagerId())
            .fireAndForget()
        )
      }
    }
  }
}
