//
//  AppView.swift
//  RocketApp
//
//  Created by David Jilek on 11.08.2022.
//

import ComposableArchitecture
import SwiftUI
import TCAExtensions

public struct RocketListView: View {
    let store: Store<RocketListState, RocketListAction>
    @ObservedObject var viewStore: ViewStore<RocketListState, RocketListAction>

    public init(store: Store<RocketListState, RocketListAction>) {
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
        RocketListView(store: .init(
            initialState: RocketListState(),
            reducer: rocketListReducer,
            environment: RocketListEnvironment(rocketClient: .live, rocketListModel: .mockData)
        ))
    }
}
