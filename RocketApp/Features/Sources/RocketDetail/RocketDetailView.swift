import ComposableArchitecture
import RocketsClient
import SwiftUI
import UIToolkit

public struct RocketDetailView: View {
  var store: StoreOf<RocketDetailCore>

  public init(store: StoreOf<RocketDetailCore>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        Text(viewStore.rocketData.id)
        Text(.diameter)
        Text(viewStore.rocketData.name)
      }
    }
  }
}

struct Rocket_Previews: PreviewProvider {
  static var previews: some View {
    RocketDetailView(
      store: .init(
        initialState: RocketDetailCore.State(rocketData: RocketDetail.mock),
        reducer: RocketDetailCore()
      )
    )
  }
}
