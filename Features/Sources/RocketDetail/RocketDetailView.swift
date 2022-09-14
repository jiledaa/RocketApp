//
//  Rocket.swift
//  RocketApp
//
//  Created by David Jilek on 07.09.2022.
//

import ComposableArchitecture
import SwiftUI
import ObjectModel
import TCAExtensions
import Networking

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
            environment: .debug(environment: RocketEnvironment(getInfoRequest: RocketInfo.mockData))
        ))
    }
}
