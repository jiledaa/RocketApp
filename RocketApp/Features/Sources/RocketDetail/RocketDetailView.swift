import ComposableArchitecture
import RocketLaunch
import RocketsClient
import SwiftUI
import UIToolkit

public struct RocketDetailView: View {
  var store: StoreOf<RocketDetailCore>
  @ObservedObject var viewStore: ViewStoreOf<RocketDetailCore>
  @BindingState var isUsMetrics = false

  public init(store: StoreOf<RocketDetailCore>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  public var body: some View {
    ScrollView {
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
              viewStore.isUsMetrics ? .usMetrics : .euMetrics,
              isOn: viewStore.binding(get: \.isUsMetrics, send: RocketDetailCore.Action.setToUSMetrics)
            )
            .padding(.horizontal)
          }
        }

        section(.firstStage) {
          stageList(items: firstStageItems)
        }
        .padding()

        section(.secondStage) {
          stageList(items: secondStageItems)
        }
        .padding()

        section(.photos) {
          VStack {
            ForEach(viewStore.rocketData.photos, id: \.self) { path in
              AsyncImage(url: URL(string: path)) { image in
                image
                  .resizable()
                  .scaledToFit()
                  .cornerRadius(24)
              } placeholder: {
                EmptyView()
              }
            }
          }
        }
      }
    }
    .padding()
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

  private func stageList(items: [StageItem]) -> some View {
    VStack(alignment: .leading) {
      ForEach(items) { item in
        HStack {
          item.image

          Text(item.text)
        }
      }
    }
  }

  private var firstStageItems: [StageItem] {
    guard let burnTime = viewStore.rocketData.firstStage.burnTime else {
      return [
        StageItem(image: .reusable, text: .reusable(viewStore.rocketData.firstStage.reusable)),
        StageItem(image: .engine, text: .engines(viewStore.rocketData.firstStage.engines)),
        StageItem(image: .fuel, text: .tonsOfFuel(viewStore.rocketData.firstStage.fuelMass))
      ]
    }

    return [
      StageItem(image: .reusable, text: .reusable(viewStore.rocketData.firstStage.reusable)),
      StageItem(image: .engine, text: .engines(viewStore.rocketData.firstStage.engines)),
      StageItem(image: .fuel, text: .tonsOfFuel(viewStore.rocketData.firstStage.fuelMass)),
      StageItem(image: .burn, text: .secondsBurnTime(burnTime))
    ]
  }

  private var secondStageItems: [StageItem] {
    guard let burnTime = viewStore.rocketData.secondStage.burnTime else {
      return [
        StageItem(image: .reusable, text: .reusable(viewStore.rocketData.secondStage.reusable)),
        StageItem(image: .engine, text: .engines(viewStore.rocketData.secondStage.engines)),
        StageItem(image: .fuel, text: .tonsOfFuel(viewStore.rocketData.secondStage.fuelMass))
      ]
    }

    return [
      StageItem(image: .reusable, text: .reusable(viewStore.rocketData.secondStage.reusable)),
      StageItem(image: .engine, text: .engines(viewStore.rocketData.secondStage.engines)),
      StageItem(image: .fuel, text: .tonsOfFuel(viewStore.rocketData.secondStage.fuelMass)),
      StageItem(image: .burn, text: .secondsBurnTime(burnTime))
    ]
  }

  private struct StageItem: Identifiable {
    let id = UUID()
    let image: Image
    let text: LocalizedStringKey
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
