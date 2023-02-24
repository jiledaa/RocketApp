import RocketListCell
import RocketDetail
import NetworkClientExtensions
import RocketsClient
import ComposableArchitecture
import Foundation

public struct RocketListCore: ReducerProtocol {
  public struct State: Equatable {
    var rocketsData = IdentifiedArrayOf<RocketListCellCore.State>()
    var rocketsError: RocketNetworkError?

    var route: Route?

    enum Route: Equatable {
      case rocketDetail(RocketDetailCore.State)
    }

    var rocketDetailState: RocketDetailCore.State? {
      if case let .rocketDetail(state) = route {
        return state
      } else {
        return nil
      }
    }

    public init() {}
  }

  public enum Action: Equatable {
    case rocketListCell(id: RocketListCellCore.State.RocketID, action: RocketListCellCore.Action)
    case setNavigation(isActive: Bool)
    case rocketDetail(RocketDetailCore.Action)
    case fetchData
    case dataFetched(Result<[RocketDetail], RocketNetworkError>)
  }

  public init() {}

  @Dependency(\.rocketsClient) var rocketsClient
  @Dependency(\.mainQueue) var mainQueue

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .rocketListCell(id: let id, action: .cellTapped):
        guard let rocketsData = state.rocketsData[id: id] else {
          return .none
        }

        state.route = .rocketDetail(.init(rocketData: rocketsData.rocketData))
        return .none

      case .setNavigation(isActive: true):
        return .none

      case .setNavigation(isActive: false):
        state.route = nil
        return .none

      case .rocketDetail:
        return .none

      case .fetchData:
        enum RocketDataFetching: Hashable {}

        return rocketsClient.getAllRockets()
          .receive(on: mainQueue)
          .catchToEffect(RocketListCore.Action.dataFetched)
          .cancellable(id: RocketDataFetching.self)

      case let .dataFetched(.success(rocketsData)):
        state.rocketsData = IdentifiedArrayOf(
          uniqueElements: rocketsData.map {
            RocketListCellCore.State(rocketData: $0)
          }
        )

        return .none

      case let .dataFetched(.failure(networkError)):
        state.rocketsError = networkError
        return .none
      }
    }
    .forEach(\.rocketsData, action: /Action.rocketListCell, element: { RocketListCellCore() })
  }
}
