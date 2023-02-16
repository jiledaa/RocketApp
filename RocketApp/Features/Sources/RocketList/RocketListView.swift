import ComposableArchitecture
import RocketsClient
import RocketListCell
import RocketDetail
import SwiftUI

public struct RocketListView: View {
  let store: StoreOf<RocketListCore>

  public init(store: StoreOf<RocketListCore>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      NavigationStack {
        VStack(spacing: 0) {
          Text("Rockets")
            .font(.title.bold())
            .padding()

          List {
            ForEachStore(
              store.scope(state: \.rocketsData, action: RocketListCore.Action.rocketListCell(id:action:)),
              content: RocketListCellView.init(store:)
            )
          }
          .navigationDestination(
            isPresented: viewStore.binding(
              get: { $0.route != nil },
              send: RocketListCore.Action.setNavigation(isActive:)
            ),
            destination: {
              IfLetStore(
                store.scope(
                  state: \.rocketDetailState,
                  action: RocketListCore.Action.rocketDetail
                )
              ) {
                RocketDetailView(store: $0)
              }
            }
          )
          .listStyle(.plain)
        }
      }
    }
  }
}

struct RocketList_Previews: PreviewProvider {
  static var previews: some View {
    RocketListView(
      store: .init(
        initialState: RocketListCore.State(
          rocketsData: [
            RocketListCellCore.State(rocketData: RocketDetail.mocks[0]),
            RocketListCellCore.State(rocketData: RocketDetail.mocks[1]),
            RocketListCellCore.State(rocketData: RocketDetail.mocks[2])
          ]
        ),
        reducer: RocketListCore()
      )
    )
  }
}
