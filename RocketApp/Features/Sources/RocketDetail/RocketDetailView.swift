import ComposableArchitecture
import RocketLaunch
import RocketsClient
import SwiftUI
import UIToolkit

public struct RocketDetailView: View {
  var store: StoreOf<RocketDetailCore>
  @ObservedObject var viewStore: ViewStore<ViewState, RocketDetailCore.Action>

  struct ViewState: Equatable {
    var rocketData: RocketDetail
    var isUsMetrics: Bool
    var toggleName: LocalizedStringKey
    var rocketLaunchState: RocketLaunchCore.State?
    var isRocketLaunchStateActive: Bool
    var firstStageItems: [StageItem]
    var secondStageItems: [StageItem]

    struct StageItem: Identifiable, Equatable {
      let id = UUID()
      let image: Image
      let text: LocalizedStringKey
    }

    init(state: RocketDetailCore.State) {
      self.rocketData = state.rocketData
      self.isUsMetrics = state.isUsMetrics
      self.toggleName = self.isUsMetrics ? .usMetrics : .euMetrics
      self.rocketLaunchState = state.rocketLaunchState
      self.isRocketLaunchStateActive = state.rocketLaunchState != nil

      self.firstStageItems =
      [
        StageItem(image: .reusable, text: .reusable(rocketData.firstStage.reusable)),
        StageItem(image: .engine, text: .engines(rocketData.firstStage.engines)),
        StageItem(image: .fuel, text: .tonsOfFuel(rocketData.firstStage.fuelMass)),
        rocketData.firstStage.burnTime.map { StageItem(image: .burn, text: .secondsBurnTime($0)) }
      ]
        .compactMap { $0 }

      self.secondStageItems =
      [
        StageItem(image: .reusable, text: .reusable(rocketData.firstStage.reusable)),
        StageItem(image: .engine, text: .engines(rocketData.firstStage.engines)),
        StageItem(image: .fuel, text: .tonsOfFuel(rocketData.firstStage.fuelMass)),
        rocketData.firstStage.burnTime.map { StageItem(image: .burn, text: .secondsBurnTime($0)) }
      ]
        .compactMap { $0 }
    }
  }

  public init(store: StoreOf<RocketDetailCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { ViewState(state: $0) })
  }

  public var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading) {
        section(.overview) {
          Text(viewStore.rocketData.overview)
            .font(.body)
        }
        .padding(.bottom)

        section(.parameters) {
          VStack {
            parameters

            Toggle(
              viewStore.toggleName,
              isOn: viewStore.binding(get: \.isUsMetrics, send: RocketDetailCore.Action.setToUSMetrics)
            )
            .padding(.horizontal)
          }
        }

        section(.firstStage) {
          stageList(items: viewStore.firstStageItems)
        }
        .padding()

        section(.secondStage) {
          stageList(items: viewStore.secondStageItems)
        }
        .padding()

        section(.photos) {
          VStack {
            ForEach(viewStore.rocketData.photos, id: \.self) { path in
              AsyncImage(
                url: URL(string: path),
                content: { $0.resizable().scaledToFit().cornerRadius(24) },
                placeholder: { EmptyView() }
              )
            }
          }
        }
      }
    }
    .padding(.horizontal)
    .navigationTitle(viewStore.rocketData.name)
    .navigationBarItems(trailing: Button(.launch) { viewStore.send(.rocketLaunchTapped) })
    .navigationDestination(
      isPresented: viewStore.binding(
        get: { $0.isRocketLaunchStateActive },
        send: RocketDetailCore.Action.setNavigation(isActive:)
      )
    ) { destination }
  }

  @ViewBuilder
  private var destination: some View {
    IfLetStore(store.scope(state: \.rocketLaunchState, action: RocketDetailCore.Action.rocketLaunch)) {
      RocketLaunchView(store: $0)
    }
  }

  @ViewBuilder
  private func section<V: View>(_ caption: LocalizedStringKey, _ content: @escaping () -> V) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(caption)
        .bold()
        .font(.body)

      content()
    }
  }

  private var parameters: some View {
    HStack(spacing: 16) {
      paramWindow(type: .height)

      paramWindow(type: .diameter)

      paramWindow(type: .mass)
    }
  }

  private func paramWindow(type: RocketDetail.RocketParameters, backgroundColor: Color = .pink) -> some View {
    VStack(spacing: 4) {
      Text(type.detail(rocketDetail: viewStore.rocketData, isUSMetrics: viewStore.isUsMetrics))
        .font(.callout)

      Text(type.name)
        .font(.caption)
    }
    .bold()
    .foregroundColor(.white)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.vertical)
    .background(Rectangle().fill(backgroundColor).cornerRadius(16))
  }

  private func stageList(items: [ViewState.StageItem]) -> some View {
    VStack(alignment: .leading) {
      ForEach(items) { item in
        HStack {
          item.image

          Text(item.text)
        }
      }
    }
  }
}

struct RocketDetail_Previews: PreviewProvider {
  static var previews: some View {
    RocketDetailView(
      store: .init(
        initialState: RocketDetailCore.State(rocketData: RocketDetail.mock),
        reducer: RocketDetailCore()
      )
    )
  }
}
