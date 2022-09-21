//
//  Rocket.swift
//  RocketApp
//
//  Created by David Jilek on 07.09.2022.
//

import SwiftUI
import RocketModels
import TCAExtensions
import ComposableArchitecture

struct RocketView: View {
    var store: Store<RocketDetailState, RocketDetailAction>
    @ObservedObject var viewStore: ViewStore<RocketDetailState, RocketDetailAction>

    init(store: Store<RocketDetailState, RocketDetailAction>) {
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
            initialState: RocketDetailState(id: UUID()),
            reducer: rocketDetailReducer.debug(),
            environment: RocketDetailEnvironment(rocketClient: .live, rocketDetailModel: .mockData)
        ))
    }
}
