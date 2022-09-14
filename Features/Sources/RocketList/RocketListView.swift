//
//  AppView.swift
//  RocketApp
//
//  Created by David Jilek on 11.08.2022.
//

import Networking
import SwiftUI
import TCAExtensions
import ComposableArchitecture

public struct AppView: View {
    let store: Store<AppState, AppAction>
    @ObservedObject var viewStore: ViewStore<AppState, AppAction>

    public init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    public var body: some View {
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
            environment: SystemEnvironment.debug(environment: AppEnvironment())
        ))
    }
}
