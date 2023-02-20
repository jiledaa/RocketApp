import RocketListCell
import RocketDetail
import Networking
import RocketsClient
import DispatchQueueExtensions
import ComposableArchitecture

public struct RocketListCore: ReducerProtocol {
  public struct State: Equatable {
    var rocketsData = IdentifiedArrayOf<RocketListCellCore.State>()
    var rocketsError: NetworkError?

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
    case rocketListCell(id: String, action: RocketListCellCore.Action)
    case setNavigation(isActive: Bool)
    case rocketDetail(RocketDetailCore.Action)
    case fetchData
    case dataFetched(Result<[RocketDetail], NetworkError>)
  }

  public init() {}

  @Dependency(\.rocketsClient) var rocketsClient
  @Dependency(\.dispatchQueue) var dispatchQueue

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      enum RocketDataFetching: Hashable {}

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

      case .fetchData:
        return rocketsClient.getAllRockets()
          .receive(on: dispatchQueue)
          .catchToEffect(RocketListCore.Action.dataFetched)
          .cancellable(id: RocketDataFetching.self)

      case let .dataFetched(.success(rocketsData)):
        rocketsData.forEach {
          state.rocketsData.append(
            contentsOf: IdentifiedArrayOf(arrayLiteral: RocketListCellCore.State(rocketData: $0))
          )
        }

        return .none

      case let .dataFetched(.failure(networkError)):
        state.rocketsError = networkError
        return .none
      }
    }
  }
}
