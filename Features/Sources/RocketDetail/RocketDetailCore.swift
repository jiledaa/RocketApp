import ComposableArchitecture
import Foundation
import Networking
import TCAExtensions

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

public struct RocketDetailEnvironment {
  public var getRocket: (String) async throws -> RocketDetail

  public init(getRocket: @escaping (String) async throws -> RocketDetail) {
    self.getRocket = getRocket
  }
}

public extension RocketDetailEnvironment {
  static func create(from factory: ApiFactory) -> Self {
    RocketDetailEnvironment(getRocket: { id in
      try await factory.getData(from: URLs.SpaceRockets.rocket(id: id))
    })
  }

  static var live: Self {
    let apiFactory = ApiFactory(requester: { try await URLSession.shared.data(from: $0) })

    return RocketDetailEnvironment.create(from: apiFactory)
  }

  static func debug(isFailing: Bool) -> RocketDetailEnvironment {
    let apiFactory = ApiFactory(requester: { _ in
      if isFailing {
        throw APIError.badURL
      }
      return (RocketDetail.rocketData, URLResponse())
    })

    return RocketDetailEnvironment.create(from: apiFactory)
  }
}

public let rocketDetailReducer = Reducer<
  RocketDetailState,
  RocketDetailAction,
  RocketDetailEnvironment
> { state, action, env in
  switch action {
  case .fetchDataResponse(.failure):
    state.rocket = nil
    return .none

  case let .fetchDataResponse(.success(response)):
    state.rocket = response
    return .none

  case let .fetchRocketData(rocket):
    enum RocketDetailID {}

    return .task { await .fetchDataResponse(TaskResult { try await env.getRocket(rocket.id) }) }
      .cancellable(id: RocketDetailID.self)
  }
}
