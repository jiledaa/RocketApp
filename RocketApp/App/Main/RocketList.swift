//
//  AppView.swift
//  RocketApp
//
//  Created by David Jilek on 11.08.2022.
//

import SwiftUI
import ComposableArchitecture
import CoreToolkit

struct AppState: Equatable {
    var rockets: IdentifiedArrayOf<RocketState> = []
}

enum AppAction: Equatable {
    case rocketAction(id: RocketState.ID, action: RocketAction)
}

struct AppEnvironment {
    
}

let appReducer = Reducer<AppState, AppAction, SystemEnvironment<AppEnvironment>>.combine(
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

struct AppView: View {
    let store: Store<AppState, AppAction>
    @ObservedObject var viewStore: ViewStore<AppState, AppAction>

    init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    var body: some View {
        NavigationView {
            List {

            }
            .navigationTitle("Rockets")
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: .init(
            initialState: AppState(),
            reducer: appReducer,
            environment: .debug(environment: AppEnvironment())
        ))
    }
}
