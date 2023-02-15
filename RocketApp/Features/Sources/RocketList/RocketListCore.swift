import ComposableArchitecture
import RocketsClient

public struct RocketListCore: ReducerProtocol {
  public struct State: Equatable {
    var rocketsData: [RocketDetail]

    public init(rocketsData: [RocketDetail]) {
      self.rocketsData = rocketsData
    }
  }

  public enum Action: Equatable {
    case fetchDataResponse(TaskResult<[RocketDetail]>)
    case fetchRocketsData
  }

  public init() {}

  @Dependency(\.rocketsClient) var rocketsClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .fetchDataResponse(.failure):
        return .none

      case let .fetchDataResponse(.success(response)):
        state.rocketsData = response
        return .none

      case .fetchRocketsData:
        return .none
      }
    }
  }
}
