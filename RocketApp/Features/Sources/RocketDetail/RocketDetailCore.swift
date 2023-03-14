import ComposableArchitecture
import Foundation
import RocketLaunch
import RocketsClient

public struct RocketDetailCore: ReducerProtocol {
  public struct State: Equatable {
    public var rocketData: RocketDetail

    var route: Route?

    enum Route: Equatable {
      case rocketLaunch(RocketLaunchCore.State)
    }

    var rocketLaunchState: RocketLaunchCore.State? {
      get {
        if case let .rocketLaunch(state) = route {
          return state
        } else {
          return nil
        }
      }

      set {
        if case let .rocketLaunch(state) = route {
          route = .rocketLaunch(newValue ?? state)
        }
      }
    }

    var isUsMetrics = false

    public init(rocketData: RocketDetail) {
      self.rocketData = rocketData
    }
  }

  public enum Action: Equatable {
    case rocketLaunchTapped
    case setNavigation(isActive: Bool)
    case setToUSMetrics
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .rocketLaunchTapped:
        state.route = .rocketLaunch(.init(rocketData: state.rocketData))
        return .none

      case .setNavigation(true):
        return .none

      case .setNavigation(false):
        state.route = nil
        return .none

      case .setToUSMetrics:
        state.isUsMetrics.toggle()
        return .none
      }
    }
//    .ifLet(\.rocketLaunchState, action: /Action.rocketLaunchTapped, then: { RocketLaunchCore() })
  }
}
