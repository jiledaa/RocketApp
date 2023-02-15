import ComposableArchitecture
import RocketsClient
import RocketListCell
import SwiftUI

public struct RocketListView: View {
  let store: StoreOf<RocketListCore>

  public init(store: StoreOf<RocketListCore>) {
    self.store = store
  }

  struct ViewState: Equatable {
    var rocketsData: [RocketDetail]

    init(state: RocketListCore.State) {
      self.rocketsData = Array(repeating: RocketDetail.mock, count: 4)
    }
  }

  public var body: some View {
    WithViewStore(self.store, observe: ViewState.init) { viewStore in
      VStack(spacing: 0) {
        Text("Rockets")
          .font(.title.bold())

        List(viewStore.rocketsData) { data in
          HStack {
            Image(systemName: "paperplane.fill")
              .resizable()
              .frame(width: 36, height: 36)
              .padding(.trailing)

            VStack(alignment: .leading, spacing: 4) {
              Text(data.name)
                .font(.title2.bold())

              Text("First flight: \(data.firstFlight)")
                .font(.callout)
                .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "arrow.forward.circle.fill")
              .resizable()
              .frame(width: 36, height: 36)
          }
        }
      }
    }
  }
}

struct RocketList_Previews: PreviewProvider {
  static var previews: some View {
    RocketListView(
      store: .init(
        initialState: RocketListCore.State(rocketsData: [RocketDetail.mock]),
        reducer: RocketListCore()
      )
    )
  }
}
