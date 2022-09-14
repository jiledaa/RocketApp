//
//  File.swift
//  
//
//  Created by David Jilek on 14.09.2022.
//

import Foundation
import Networking
import ObjectModel
import TCAExtensions
import ComposableArchitecture

public struct RocketState: Equatable, Identifiable {
    public let id: UUID
    var rocketInfo: RocketInfo?

    public init(id: UUID = UUID(), rocketInfo: RocketInfo? = nil) {
        self.id = id
        self.rocketInfo = rocketInfo
    }

    struct RocketData: Equatable {
        let id: RocketInfo.ID
        let type: String
        let overView: String
        let parameters: Parameters
        let firstStage: Stage
        let secondStage: Stage
        let photos: Data

        struct Parameters: Equatable {
            let height: String
            let diameter: String
            let mass: String
        }

        struct Stage: Equatable {
            let reusable: String
            let engines: String
            let fuelMass: String
            let burnTime: String
        }
    }
}

public enum RocketAction: Equatable {
    case getInfo(RocketInfo.ID, TaskResult<RocketInfo>)
}

public struct RocketEnvironment {
    var getInfoRequest: (JSONDecoder) -> Effect<RocketInfo, APIError>

    public init(getInfoRequest: @escaping (JSONDecoder) -> Effect<RocketInfo, APIError>) {
        self.getInfoRequest = getInfoRequest
    }
}

public let rocketReducer = Reducer<RocketState, RocketAction, SystemEnvironment<RocketEnvironment>> { state, action, env in
    switch action {

    case .getInfo(_, .failure):
        state.rocketInfo = nil
        return .none

    case let .getInfo(id, .success(rocketInfo)):
        return .none
    }
}
