import ComposableArchitecture
import RocketsClient
import SwiftUI

struct RocketDetailView: View {
  var store: StoreOf<RocketDetailCore>

  init(store: StoreOf<RocketDetailCore>) {
    self.store = store
  }

  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        Text(viewStore.rocket?.id ?? "")
      }
    }
  }
}

struct Rocket_Previews: PreviewProvider {
  static var previews: some View {
    RocketDetailView(
      store: .init(
        initialState: RocketDetailCore.State(rocket: RocketDetail.mock),
        reducer: RocketDetailCore()
      )
    )
  }
}
