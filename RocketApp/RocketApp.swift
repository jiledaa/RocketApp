import ComposableArchitecture
import RocketList
import RocketsClient
import SwiftUI

@main
struct RocketApp: App {
  var body: some Scene {
    WindowGroup {
      RocketListView(store: Store(
        initialState: RocketListState(rocketsData: []),
        reducer: rocketListReducer.debug(),
        environment: .init()
      ))
    }
  }
}
