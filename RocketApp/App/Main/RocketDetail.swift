//
//  Rocket.swift
//  RocketApp
//
//  Created by David Jilek on 07.09.2022.
//

import ComposableArchitecture
import SwiftUI
import Networking

struct RocketState: Equatable, Identifiable {
    var id: UUID
    var rocketInfo: RocketInfo?

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

enum RocketAction: Equatable {
    case getInfo(RocketInfo.ID, TaskResult<RocketInfo>)
}

struct RocketEnvironment {
    var getInfoRequest: (JSONDecoder) -> Effect<RocketInfo, APIError>
}

let rocketReducer = Reducer<RocketState, RocketAction, SystemEnvironment<RocketEnvironment>> { state, action, env in
    switch action {

    case .getInfo(_, .failure):
        state.rocketInfo = nil
        return .none

    case let .getInfo(id, .success(rocketInfo)):
        return .none
    }
}

struct RocketView: View {
    var store: Store<RocketState, RocketAction>
    @ObservedObject var viewStore: ViewStore<RocketState, RocketAction>

    init(store: Store<RocketState, RocketAction>) {
        self.store = store
        viewStore = ViewStore(store)
    }

    var body: some View {
        VStack {

        }
    }
}

struct Rocket_Previews: PreviewProvider {
    static var previews: some View {
        RocketView(store: .init(
            initialState: RocketState(id: UUID()),
            reducer: rocketReducer.debug(),
            environment: .debug(environment: RocketEnvironment(getInfoRequest: mockDataEffect))
        ))
    }
}
