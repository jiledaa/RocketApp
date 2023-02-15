import ComposableArchitecture
import RocketsClient
import SwiftUI

public struct RocketListView: View {
  let store: StoreOf<RocketListCore>

  public init(store: StoreOf<RocketListCore>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      Text("\(viewStore.rockets.count)")
        .onAppear {
          viewStore.send(.fetchRocketsData)
        }
    }
  }
}

struct RocketList_Previews: PreviewProvider {
  static var previews: some View {
    RocketListView(
      store: .init(
        initialState: RocketListCore.State(rocketsData: [RocketDetail.mock]),
        reducer: RocketListCore()
      )
    )
  }
}
