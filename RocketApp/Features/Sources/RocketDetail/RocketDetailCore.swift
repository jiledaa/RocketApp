import ComposableArchitecture
import Foundation
import RocketsClient

public struct RocketDetailState: Equatable {
  public var rocket: RocketDetail?

  public init(rocket: RocketDetail? = nil) {
    self.rocket = rocket
  }
}

public enum RocketDetailAction: Equatable {
  case fetchDataResponse(TaskResult<RocketDetail>)
  case fetchRocketData(RocketDetail)
}

public struct RocketDetailEnvironment {}

public extension RocketDetailEnvironment {}

public let rocketDetailReducer = Reducer<
  RocketDetailState,
  RocketDetailAction,
  RocketDetailEnvironment
> { state, action, _ in
  switch action {
  case .fetchDataResponse(.failure):
    state.rocket = nil
    return .none

  case let .fetchDataResponse(.success(response)):
    state.rocket = response
    return .none

  case let .fetchRocketData(rocket):
    enum RocketDetailID {}

    return .none
  }
}
