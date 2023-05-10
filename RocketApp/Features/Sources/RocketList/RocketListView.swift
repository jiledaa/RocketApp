import ComposableArchitecture
import CoreToolkit
import NetworkClientExtensions
import RocketDetail
import RocketListCell
import RocketsClient
import SwiftUI
import UIToolkit

public struct RocketListView: View {
  let store: StoreOf<RocketListCore>
  @ObservedObject var viewStore: ViewStore<ViewState, RocketListCore.Action>

  struct ViewState: Equatable {
    var loadingStatus: Loadable<IdentifiedArrayOf<RocketListCellCore.State>, RocketsClientAsyncError>
    var isRouteActive: Bool

    init(state: RocketListCore.State) {
      self.loadingStatus = state.loadingStatus
      self.isRouteActive = state.route != nil
    }
  }

  public init(store: StoreOf<RocketListCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }

  public var body: some View {
    NavigationStack {
      Group {
        switch viewStore.loadingStatus {
        case let .success(data):
          rocketsListView(rocketData: data)
        case let .failure(error):
          errorView(error: error)
        default:
          loadingView
        }
      }
      .navigationTitle(.rockets)
    }
    .task { viewStore.send(.fetchData) }
  }

  @ViewBuilder
  private func rocketsListView(rocketData: IdentifiedArrayOf<RocketListCellCore.State>) -> some View {
    List {
      ForEachStore(store.scope(state: \.loadingStatus.arrayData, action: RocketListCore.Action.rocketListCell)) {
        RocketListCellView(store: $0)
      }
    }
    .listStyle(.sidebar)
    .navigationDestination(
      isPresented: viewStore.binding(
        get: { $0.isRouteActive },
        send: RocketListCore.Action.setNavigation(isActive:)
      )
    ) { destination }
  }

  @ViewBuilder
  private var destination: some View {
    IfLetStore(store.scope(state: \.rocketDetailState, action: RocketListCore.Action.rocketDetail)) {
      RocketDetailView(store: $0)
    }
  }

  @ViewBuilder
  private func errorView(error: RocketsClientAsyncError) -> some View {
    Group {
      Spacer()

      Image.error
        .resizable()
        .frame(width: 88, height: 88)
        .padding(.bottom)

      Text(.error)
        .font(.headline)
        .padding(.bottom, 4)

      Text("\(error.userDescription)")

      Text("\(error.description)")
        .multilineTextAlignment(.leading)
        .padding()

      Spacer()
    }
    .padding(.horizontal)
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
