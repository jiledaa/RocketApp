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
        environment: .live
      ))
    }
  }
}
