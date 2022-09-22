//
//  File.swift
//  
//
//  Created by David Jilek on 14.09.2022.
//

import ComposableArchitecture
import RocketDetail
import RocketModels
import TCAExtensions

public struct RocketListState: Equatable {
    var rockets: IdentifiedArrayOf<RocketDetailState> = []

    public init(rockets: IdentifiedArrayOf<RocketDetailState> = []) {
        self.rockets = rockets
    }
}

public enum RocketListAction: Equatable {
    case rocketAction(id: RocketDetailState.ID, action: RocketDetailAction)
}

public struct RocketListEnvironment {
    var rocketClient: RocketClient
    var rocketListModel: RocketListModel

    public init(rocketClient: RocketClient, rocketListModel: RocketListModel) {
        self.rocketClient = rocketClient
        self.rocketListModel = rocketListModel
    }
}

public let rocketListReducer = Reducer<
    RocketListState,
    RocketListAction,
    RocketListEnvironment
>.combine(
    rocketDetailReducer.forEach(
        state: \.rockets,
        action: /RocketListAction.rocketAction,
        environment: { _ in .init(rocketClient: .live, rocketDetailModel: .mockData) }
    ),
    Reducer { _, action, _ in
        switch action {

        case let .rocketAction(id: id, action: action):
            return .none
        }
    }
)
