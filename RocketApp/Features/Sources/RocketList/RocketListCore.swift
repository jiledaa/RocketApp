import ComposableArchitecture
import RocketDetail
import RocketsClient

public struct RocketListState: Equatable {
  var rockets: [RocketDetail]

  public init(rocketsData: [RocketDetail]) {
    self.rockets = rocketsData
  }
}

public enum RocketListAction: Equatable {
  case fetchDataResponse(TaskResult<[RocketDetail]>)
  case fetchRocketsData
}

public struct RocketListEnvironment {

  public init() {}
}

public extension RocketListEnvironment {}

public let rocketListReducer = Reducer<
  RocketListState,
  RocketListAction,
  RocketListEnvironment
> { state, action, _ in
  switch action {

  case .fetchDataResponse(.failure):
    return .none

  case let .fetchDataResponse(.success(response)):
    state.rockets = response
    return .none

  case .fetchRocketsData:
    return .none
  }
}
  .debug()
