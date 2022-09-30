//
//  RocketApp.swift
//  RocketApp
//
//  Created by David Jilek on 06.09.2022.
//

import ComposableArchitecture
import Networking
import RocketList
import SwiftUI

@main
struct RocketApp: App {
    var body: some Scene {
        WindowGroup {
            RocketListView(store: Store(
                initialState: RocketListState(rocketsData: []),
                reducer: rocketListReducer.debug(),
                environment: .live(
//                    ApiFactory: ApiFactory(requester: { url in
//                        switch url {
//                        case "/rockets":
//                            return [Rockets].json
//                        case "/rocket":
//                            return Rocket(....).json
//                        }
//                    })
                    apiFactory: ApiFactory(requester: { try await URLSession.shared.data(from: $0) })
                )
            ))
        }
    }
}
