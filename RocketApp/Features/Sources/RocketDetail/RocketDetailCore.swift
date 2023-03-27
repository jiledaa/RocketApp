import ComposableArchitecture
import Foundation
import RocketLaunch
import RocketsClient

public struct RocketDetailCore: ReducerProtocol {
  public struct State: Equatable {
    public var rocketData: RocketDetail
    var isUsMetrics = false

    var rocketLaunchState: RocketLaunchCore.State?

    public init(rocketData: RocketDetail) {
      self.rocketData = rocketData
    }
  }

  public enum Action: Equatable {
    case rocketLaunchTapped
    case rocketLaunch(RocketLaunchCore.Action)
    case setNavigation(isActive: Bool)
    case setToUSMetrics
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .rocketLaunchTapped:
        state.rocketLaunchState = .init(rocketData: state.rocketData)
        return .none

      case .setNavigation(true):
        return .none

      case .setNavigation(false):
        return EffectTask.task { .rocketLaunch(.onDisappear) }

      case .rocketLaunch(.onDisappear):
        state.rocketLaunchState = nil
        return .none

      case .setToUSMetrics:
        state.isUsMetrics.toggle()
        return .none

      case .rocketLaunch:
        return .none
      }
    }
    .ifLet(\.rocketLaunchState, action: /Action.rocketLaunch) { RocketLaunchCore() }
  }
}
