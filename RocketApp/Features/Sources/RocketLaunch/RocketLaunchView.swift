import ComposableArchitecture
import RocketsClient
import SwiftUI
import UIToolkit

public struct RocketLaunchView: View {
  public let store: StoreOf<RocketLaunchCore>
  @ObservedObject var viewStore: ViewStoreOf<RocketLaunchCore>

  @State var backgroundOpacity: CGFloat = 0
  @State var blinkOpacity: CGFloat = 0
  @State var rocketScale: CGFloat = 1
  @State var pollutionScale: CGFloat = 0.5

  public init(store: StoreOf<RocketLaunchCore>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  public var body: some View {
    VStack(spacing: 0) {
      Spacer()

      HStack {
        Spacer()
          .frame(maxWidth: viewStore.lWidth)

        // TODO: All view logic move to ViewState.
        if viewStore.rocketHasLaunched {
          flyingRocket
        } else {
          Image.rocketIdle
        }

        Spacer()
          .frame(maxWidth: viewStore.rWidth)
      }

      Spacer()
        .frame(maxHeight: max(viewStore.height, 0))

      platform
    }
    .frame(height: UIScreen.main.bounds.height)
    .ignoresSafeArea()
    .background {
      ZStack {
        space

        daySky
      }
    }
    .overlay { flash }
    .overlay {
      if let error = viewStore.motionError {
        errorView(error)
      }
    }
    .onAppear { viewStore.send(.onAppear) }
  }

  private var flyingRocket: some View {
    Image.rocketFlying.opacity(2)
      .scaleEffect(rocketScale)
      .overlay(alignment: .bottom) {
        Group {
          HStack {
            ForEach((1...3), id: \.self) { _ in
              Circle()
                .trim(from: 0, to: 0.6)
                .stroke()
            }
          }
          .frame(width: 100, height: 100)

          HStack {
            ForEach((1...2), id: \.self) { _ in
              Circle()
                .trim(from: 0, to: 0.6)
                .stroke()
            }
          }
          .frame(width: 80, height: 100)
        }
        .offset(y: 50)
        .foregroundColor(.gray)
        .scaleEffect(pollutionScale)
        .onAppear {
          withAnimation(
            Animation.easeInOut(duration: 0.08)
              .repeatForever(autoreverses: true)
          ) {
            rocketScale = 0.99
            pollutionScale = 1
          }
        }
        .onDisappear {
          rocketScale = 1
          pollutionScale = 0.5
        }
      }
  }

  @ViewBuilder
  private var platform: some View {
    ZStack(alignment: .top) {
      Rectangle()
        .fill(.indigo)
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
        .frame(height: 100)
        .opacity(viewStore.rocketHasLaunched ? 0 : 1)

      VStack {
        HStack {
          Spacer()

          Text(viewStore.rocketHasLaunched ? .launchSuccessful : .tiltToLaunch(viewStore.rocketData.name))
            .font(.headline)
            .multilineTextAlignment(.center)
            .bold()
            .foregroundColor(viewStore.rocketHasLaunched ? .indigo : .white)
            .opacity(1 - backgroundOpacity)

          Spacer()

          if !viewStore.rocketHasLaunched {
            launchCounter
          }
        }
        .padding([.top, .trailing, .leading])

        if viewStore.rocketHasLaunched
            && viewStore.neededTiltToLaunch - viewStore.calculatedHeight > viewStore.neededTiltToLaunch {
          Button(.resetLaunch) { viewStore.send(.resetLaunch) }
            .buttonStyle(.borderedProminent)
            .cornerRadius(12)
        }
      }
    }
  }

  private var launchCounter: some View {
    ZStack {
      Rectangle()
        .fill(AngularGradient(gradient: Gradient(colors: [.black, .gray]), center: .bottom))
        .frame(width: 40, height: 40)
        .cornerRadius(12)

      Rectangle()
        .fill(.white)
        .frame(width: 28, height: 28)
        .cornerRadius(4)

      Text("\(Int(viewStore.neededTiltToLaunch - viewStore.calculatedHeight))").foregroundColor(.black)
    }
  }

  private var space: some View {
    Image.space
      .ignoresSafeArea()
      .opacity(backgroundOpacity)
      .offset(x: CGFloat(viewStore.pitch * -80), y: CGFloat(viewStore.roll * -80))
      .transition(.move(edge: .top))
      .onChange(of: viewStore.rocketHasLaunched) { hasLaunched in
        withAnimation(.easeInOut(duration: 15)) {
          if hasLaunched {
            backgroundOpacity = 1
          }
        }

        if !hasLaunched {
          backgroundOpacity = 0
        }
      }
  }

  private var daySky: some View {
    LinearGradient(
        gradient: Gradient(stops: [
          .init(color: .blue.opacity(0.5), location: 0),
          .init(color: .white, location: 0.7)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    .opacity(1 - backgroundOpacity)
  }

  private var flash: some View {
    Color.yellow
      .ignoresSafeArea()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .opacity(blinkOpacity)
      .onChange(of: viewStore.rocketHasLaunched) { _ in
        blinkOpacity = 1
        withAnimation(Animation.spring().delay(0.05)) { blinkOpacity = 0 }
      }
  }

  private func errorView(_ error: NSError) -> some View {
    withAnimation {
      VStack {
        Image.spaceError.opacity(0.5)

        Text("\(error)")
      }
    }
  }
}

struct RocketLaunch_Previews: PreviewProvider {
  static var previews: some View {
    RocketLaunchView(
      store: .init(
        initialState: RocketLaunchCore.State(rocketData: RocketDetail.mock, rocketHasLaunched: false),
        reducer: RocketLaunchCore()
      )
    )
  }
}
