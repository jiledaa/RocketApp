import ComposableArchitecture
import Foundation
import RocketsClient

public struct RocketLaunchCore: ReducerProtocol {
  public struct State: Equatable {
    public var rocketData: RocketDetail

    public init(rocketData: RocketDetail) {
      self.rocketData = rocketData
    }
  }

  public enum Action: Equatable {
    case launch
    case drop
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .launch:
        return .none

      case .drop:
        return .none
      }
    }
  }
}
