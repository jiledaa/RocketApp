import SwiftUI
import RocketsClient
import ComposableArchitecture

struct RocketListCellView: View {
  let store: StoreOf<RocketListCellCore>

  init(store: StoreOf<RocketListCellCore>) {
    self.store = store
  }

  var body: some View {
    WithViewStore(self.store) { viewStore in
      Text(viewStore.rocketDetail.id)
    }
  }
}

struct RocketListCellView_Previews: PreviewProvider {
  static var previews: some View {
    RocketListCellView(
      store: .init(
        initialState: RocketListCellCore.State(rocketDetail: RocketDetail.mock),
        reducer: RocketListCellCore()
      )
    )
  }
}
