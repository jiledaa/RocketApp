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
    GeometryReader { _ in
      VStack(spacing: 0) {

        Spacer()
          .frame(maxHeight: viewStore.height)

        HStack {
          Spacer()
            .frame(maxWidth: -viewStore.width)

          viewStore.rocketHasLaunched ? Image.rocketFlying : Image.rocketIdle

          Spacer()
            .frame(maxWidth: abs(viewStore.width))
        }
        // .position(x: proxy.frame(in: .named("platform")).origin.x, y: proxy.frame(in: .named("platform")).midY)
        Spacer()

        platform
      }
    }
    .onAppear {
      viewStore.send(.onAppear)
    }
  }

  @ViewBuilder
  private var platform: some View {
    if viewStore.rocketHasLaunched {
      EmptyView()
    } else {
      ZStack {
        Rectangle()
          .fill(.black.opacity(0.7))
          .edgesIgnoringSafeArea(.bottom)
          .frame(height: 100)
          .coordinateSpace(name: "platform")

        Text(.moveUp)
          .bold()
          .padding(.horizontal)
          .foregroundColor(.white)
      }
    }
  }
}

struct RocketLaunch_Previews: PreviewProvider {
  static var previews: some View {
    RocketLaunchView(
      store: .init(
        initialState: RocketLaunchCore.State(rocketData: RocketDetail.mock),
        reducer: RocketLaunchCore()
      )
    )
  }
}
