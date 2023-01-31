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
    Text("\(viewStore.rockets.count)")
      .onAppear {
        viewStore.send(.fetchRocketsData)
      }
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    RocketListView(
      store: .init(
        initialState: RocketListState(rocketsData: []),
        reducer: rocketListReducer,
        environment: .debug(isFailing: false)
      )
    )
  }
}
