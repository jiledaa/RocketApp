//
//  File.swift
//  
//
//  Created by David Jilek on 14.09.2022.
//

import ComposableArchitecture
import Networking
import RocketDetail
import TCAExtensions

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
  public var getRockets: () async throws -> [RocketDetail]
  
  public init(getRockets: @escaping () async throws -> [RocketDetail]) {
    self.getRockets = getRockets
  }
}

public extension RocketListEnvironment {
  static func create(from factory: ApiFactory) -> Self {
    RocketListEnvironment(getRockets: {
      try await factory.getData(from: URLs.SpaceRockets.allRockets)
    })
  }
  
  static var live: Self {
    let apiFactory = ApiFactory(requester: { try await URLSession.shared.data(from: $0) })
    
    return RocketListEnvironment.create(from: apiFactory)
  }
  
  static func debug(isFailing: Bool) -> RocketListEnvironment {
    let apiFactory = ApiFactory(requester: { _ in
      if isFailing {
        throw APIError.badURL
      }
      return (RocketDetail.rocketsData, URLResponse())
    })
    
    return RocketListEnvironment.create(from: apiFactory)
  }
}

public let rocketListReducer = Reducer<RocketListState, RocketListAction, RocketListEnvironment> { state, action, env in
  switch action {
    
  case .fetchDataResponse(.failure):
    return .none
    
  case let .fetchDataResponse(.success(response)):
    state.rockets = response
    return .none
    
  case .fetchRocketsData:
    return .task { await .fetchDataResponse(TaskResult { try await env.getRockets() }) }
  }
}.debug()
