//
//  File.swift
//  
//
//  Created by David Jilek on 14.09.2022.
//

import Foundation
import Networking
import RocketModels
import TCAExtensions
import ComposableArchitecture

public struct RocketDetailState: Equatable, Identifiable {
    public let id: UUID
    public var rocketInfo: RocketDetailModel?

    public init(id: UUID = UUID(), rocketInfo: RocketDetailModel? = nil) {
        self.id = id
        self.rocketInfo = rocketInfo
    }

    struct RocketData: Equatable {
        let id: RocketDetailModel.ID
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

public enum RocketDetailAction: Equatable {
    case mock
}

public struct RocketDetailEnvironment {
    var rocketClient: RocketClient
    var rocketDetailModel: RocketDetailModel

    public init(rocketClient: RocketClient, rocketDetailModel: RocketDetailModel) {
        self.rocketClient = rocketClient
        self.rocketDetailModel = rocketDetailModel
    }
//    var getInfoRequest: (JSONDecoder) -> Effect<RocketDetailModel, APIError>
//
//    public init(getInfoRequest: @escaping (JSONDecoder) -> Effect<RocketDetailModel, APIError>) {
//        self.getInfoRequest = getInfoRequest
//    }
}

public let rocketDetailReducer = Reducer<
    RocketDetailState,
    RocketDetailAction,
    RocketDetailEnvironment
> { state, action, env in
    switch action {
    case .mock:
        return .none

    }
}
