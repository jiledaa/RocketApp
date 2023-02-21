import RocketListCell
import RocketDetail
import SwiftUI
import Networking
import ComposableArchitecture

public struct RocketListView: View {
  let store: StoreOf<RocketListCore>
  @ObservedObject var viewStore: ViewStoreOf<RocketListCore>

  public init(store: StoreOf<RocketListCore>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  public var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        Text("Rockets")
          .font(.title.bold())
          .padding()

        switch viewStore.rocketsError {
        case let .some(error):
          errorView(error: error)
        case .none:
          rocketsList
        }
      }
    }
    .onAppear { viewStore.send(.fetchData) }
  }

  @ViewBuilder
  private var rocketsList: some View {
    List {
      ForEachStore(store.scope(state: \.rocketsData, action: RocketListCore.Action.rocketListCell(id:action:))) {
        RocketListCellView(store: $0)
      }
    }
    .listStyle(.plain)
    .navigationDestination(
      isPresented: viewStore.binding(
        get: { $0.route != nil },
        send: RocketListCore.Action.setNavigation(isActive:)
      ),
      destination: { destinaion }
    )
  }

  @ViewBuilder
  private var destinaion: some View {
    IfLetStore(store.scope(state: \.rocketDetailState, action: RocketListCore.Action.rocketDetail)) {
      RocketDetailView(store: $0)
    }
  }

  @ViewBuilder
  private func errorView(error: NetworkError) -> some View {
    Group {
      Spacer()

      Image(systemName: "xmark.octagon.fill")
        .resizable()
        .frame(width: 32, height: 32)
        .padding()

      Text("Cannot load data, cause:")
        .font(.headline)

      Text("\(error.cause.description)")

      Spacer()
    }
    .foregroundColor(.red)
  }
}

struct RocketList_Previews: PreviewProvider {
  static var previews: some View {
    RocketListView(
      store: .init(
        initialState: RocketListCore.State(),
        reducer: RocketListCore()
      )
    )
  }
}
