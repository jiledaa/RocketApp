import ComposableArchitecture
import Foundation
import RocketsClient

public struct RocketDetailCore: ReducerProtocol {
  public struct State: Equatable {
    public var rocketData: RocketDetail

    public init(rocketData: RocketDetail) {
      self.rocketData = rocketData
    }
  }

  public enum Action: Equatable {
    case rocketLaunchTapped
  }

  public init() {}

  @Dependency(\.rocketsClient) var rocketsClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .rocketLaunchTapped:
        return .none
      }
    }
  }
}
