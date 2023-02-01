import ComposableArchitecture
import RocketsClient
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
