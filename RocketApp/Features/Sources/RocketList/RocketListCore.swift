import ComposableArchitecture
import RocketsClient
import RocketListCell
import RocketDetail

public struct RocketListCore: ReducerProtocol {
  public struct State: Equatable {
    var rocketsData: IdentifiedArrayOf<RocketListCellCore.State>
    
    var route: Route?
    var rocketDetailState: RocketDetailCore.State? {
      if case let .rocketDetail(state) = route {
        return state
      } else {
        return nil
      }
    }

    enum Route: Equatable {
      case rocketDetail(RocketDetailCore.State)
    }

    public init(
      rocketsData: IdentifiedArrayOf<RocketListCellCore.State> = [
        RocketListCellCore.State(rocketData: RocketDetail.mocks[0]),
        RocketListCellCore.State(rocketData: RocketDetail.mocks[1]),
        RocketListCellCore.State(rocketData: RocketDetail.mocks[2])
      ]
    ) {
      self.rocketsData = rocketsData
    }
  }

  public enum Action: Equatable {
    case rocketListCell(id: String, action: RocketListCellCore.Action)
    case setNavigation(isActive: Bool)
    case rocketDetail(RocketDetailCore.Action)
  }

  public init() {}

  @Dependency(\.rocketsClient) var rocketsClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .rocketListCell(id: let id, action: .cellTapped):
        guard let rocketsData = state.rocketsData[id: id] else {
          return .none
        }

        state.route = .rocketDetail(.init(rocketData: rocketsData.rocketData))
        return .none

      case .setNavigation(isActive: let isActive):
        switch isActive {
        case true:
          return .none

        case false:
          state.route = nil
        }

        return .none

      case .rocketDetail:
        return .none
      }
    }
  }
}
