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
    public var getRockets: @Sendable () async throws -> [RocketDetail]

    public init(getRockets: @escaping @Sendable () async throws -> [RocketDetail]) {
        self.getRockets = getRockets
    }
}

public extension RocketListEnvironment {

    static let live = RocketListEnvironment(getRockets: {
        try await ApiFactory.getData(from: URLs.SpaceRockets.allRockets)
    })

    static func debug(isFailing: Bool) -> RocketListEnvironment {
        RocketListEnvironment(getRockets: {
            if isFailing {
                throw APIError.badURL
            } else {
                return [RocketDetail.mock]
            }
        })
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
        enum RocketListID {}

        return .task { await .fetchDataResponse(TaskResult { try await env.getRockets() }) }
            .cancellable(id: RocketListID.self)
    }
}
