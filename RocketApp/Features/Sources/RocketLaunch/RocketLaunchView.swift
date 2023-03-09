import ComposableArchitecture
import RocketsClient
import SwiftUI
import UIToolkit

public struct RocketLaunchView: View {
  public let store: StoreOf<RocketLaunchCore>
  @ObservedObject var viewStore: ViewStoreOf<RocketLaunchCore>

  public init(store: StoreOf<RocketLaunchCore>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  public var body: some View {
    Image.rocketIdle
  }
}

struct RocketLaunchView_Previews: PreviewProvider {
  static var previews: some View {
    RocketLaunchView(
      store: .init(
        initialState: RocketLaunchCore.State(rocketData: RocketDetail.mock),
        reducer: RocketLaunchCore()
      )
    )
  }
}
