//
//  RocketApp.swift
//  RocketApp
//
//  Created by David Jilek on 06.09.2022.
//

import RocketList
import ComposableArchitecture
import SwiftUI

@main
struct RocketApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(
                initialState: AppState(),
                reducer: appReducer.debug(),
                environment: .live(environment: AppEnvironment())
            ))
        }
    }
}
