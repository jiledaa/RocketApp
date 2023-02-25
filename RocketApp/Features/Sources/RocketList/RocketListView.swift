import SwiftUI
import RocketListCell
import RocketDetail
import NetworkClientExtensions
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
      VStack {
        switch viewStore.rocketsError {
        case .none:
          rocketsListView
        case let .some(error):
          errorView(error: error)
        }
      }
      .navigationTitle("Rockets")
    }
    .overlay {
      if viewStore.isLoading {
        loadingView
      }
    }
    .task { viewStore.send(.fetchData) }
  }

  @ViewBuilder
  private var rocketsListView: some View {
    List {
      ForEachStore(store.scope(state: \.rocketsData, action: RocketListCore.Action.rocketListCell)) {
        RocketListCellView(store: $0)
      }
    }
    .listStyle(.plain)
    .navigationDestination(
      isPresented: viewStore.binding(
        get: { $0.route != nil },
        send: RocketListCore.Action.setNavigation(isActive:)
      ),
      destination: { destination }
    )
  }

  @ViewBuilder
  private var destination: some View {
    IfLetStore(store.scope(state: \.rocketDetailState, action: RocketListCore.Action.rocketDetail)) {
      RocketDetailView(store: $0)
    }
  }

  @ViewBuilder
  private func errorView(error: RocketNetworkError) -> some View {
    Group {
      Spacer()

      Image(systemName: "xmark.octagon.fill")
        .resizable()
        .frame(width: 32, height: 32)
        .padding()

      Text("Cannot load data, cause:")
        .font(.headline)

      Text("\(error.description)")

      Spacer()
    }
    .foregroundColor(.red)
  }

  private var loadingView: some View {
    ProgressView()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.gray.opacity(0.4))
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
