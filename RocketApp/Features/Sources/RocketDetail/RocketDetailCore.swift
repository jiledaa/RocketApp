import ComposableArchitecture
import Foundation
import RocketsClient

public struct RocketDetailCore: ReducerProtocol {
  public struct State: Equatable {
    public var rocket: RocketDetail?

    public init(rocket: RocketDetail? = nil) {
      self.rocket = rocket
    }
  }

  public enum Action: Equatable {
    case fetchDataResponse(TaskResult<RocketDetail>)
    case fetchRocketData(RocketDetail)
  }

  public init() {}

  @Dependency(\.rocketsClient) var rocketsClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .fetchDataResponse(.failure):
        state.rocket = nil
        return .none

      case let .fetchDataResponse(.success(response)):
        state.rocket = response
        return .none

      case .fetchRocketData:
        enum RocketDetailID {}

        return .none
      }
    }
  }
}
