//
//  File.swift
//  
//
//  Created by David Jilek on 14.09.2022.
//

import RocketDetail
import TCAExtensions
import ComposableArchitecture

public struct AppState: Equatable {
    var rockets: IdentifiedArrayOf<RocketState> = []

    public init(rockets: IdentifiedArrayOf<RocketState> = []) {
        self.rockets = rockets
    }
}

public enum AppAction: Equatable {
    case rocketAction(id: RocketState.ID, action: RocketAction)
}

public struct AppEnvironment {
    public init() {}
}

public let appReducer = Reducer<AppState, AppAction, SystemEnvironment<AppEnvironment>>.combine(
    rocketReducer.forEach(
        state: \.rockets,
        action: /AppAction.rocketAction,
        environment: { _ in .live(environment: RocketEnvironment(getInfoRequest: getDataEffect)) }
    ),
    Reducer { state, action, env in
        switch action {

        case .rocketAction(id: let id, action: let action):
            return .none
        }
    }
)
