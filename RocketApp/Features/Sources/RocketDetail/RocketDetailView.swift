import ComposableArchitecture
import RocketLaunch
import RocketsClient
import SwiftUI
import UIToolkit

public struct RocketDetailView: View {
  var store: StoreOf<RocketDetailCore>
  @ObservedObject var viewStore: ViewStoreOf<RocketDetailCore>

  public init(store: StoreOf<RocketDetailCore>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  public var body: some View {
      VStack {
        Text(viewStore.rocketData.id)
        Text(.diameter)
        Text(viewStore.rocketData.name)
      }
      .navigationTitle(viewStore.rocketData.name)
      .navigationBarItems(
        trailing: Button(.launch) {
          viewStore.send(.rocketLaunchTapped)
        }
      )
      .navigationDestination(
        isPresented: viewStore.binding(
          get: { $0.route != nil },
          send: RocketDetailCore.Action.setNavigation(isActive:)
        ),
        destination: { destination }
      )
//      .toolbar(id: viewStore.rocketData.id) {
//        ToolbarItem(id: viewStore.rocketData.id, placement: .navigationBarLeading) {
//          Text(viewStore.rocketData.name)
//        }
//
//        ToolbarItem(id: viewStore.rocketData.id, placement: .navigationBarTrailing) {
//          Button(.launch) {
//            viewStore.send(.rocketLaunchTapped)
//          }
//        }
//      }
  }

  @ViewBuilder
  private var destination: some View {
    IfLetStore(
      store.scope(state: \.rocketLaunchState, action: { _ in  RocketDetailCore.Action.rocketLaunchTapped }),
      then: RocketLaunchView.init
    )
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
