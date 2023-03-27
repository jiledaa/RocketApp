import ComposableArchitecture
import CoreToolkit
import Foundation
import NetworkClientExtensions
import RocketDetail
import RocketListCell
import RocketsClient

public struct RocketListCore: ReducerProtocol {
  public struct State: Equatable {
    var loadingStatus: Loadable<IdentifiedArrayOf<RocketListCellCore.State>, RocketNetworkError> = .notRequested

    var rocketDetailState: RocketDetailCore.State?

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
        guard let rocketData = state.loadingStatus.data?[id: id] else {
          return .none
        }

        state.rocketDetailState = .init(rocketData: rocketData.rocketData)
        return .none

      case .setNavigation(isActive: true):
        return .none

      case .setNavigation(isActive: false):
        state.rocketDetailState = nil
        return .none

      case .rocketDetail:
        return .none

      case .fetchData:
        enum RocketDataFetching: Hashable {}

        state.loadingStatus = .loading

        return rocketsClient.getAllRockets()
          .receive(on: mainQueue)
          .catchToEffect(RocketListCore.Action.dataFetched)
          .cancellable(id: RocketDataFetching.self, cancelInFlight: true)

      case let .dataFetched(.success(rocketsData)):
        state.loadingStatus = .success(
          IdentifiedArrayOf(
            uniqueElements: rocketsData.map {
              RocketListCellCore.State(rocketData: $0)
            }
          )
        )

        return .none

      case let .dataFetched(.failure(networkError)):
        state.loadingStatus = .failure(networkError)
        return .none
      }
    }
    .forEach(\.loadingStatus.arrayData, action: /Action.rocketListCell) { RocketListCellCore() }
    .ifLet(\.rocketDetailState, action: /Action.rocketDetail) { RocketDetailCore() }
  }
}

// TODO: Make it generic and move to Loadable.
extension Loadable<IdentifiedArrayOf<RocketListCellCore.State>, RocketNetworkError> {
  var arrayData: IdentifiedArrayOf<RocketListCellCore.State> {
    get {
      switch self {
      case let .success(data):
        return data
      default:
        return []
      }
    }

    set {
      self = .success(newValue)
    }
  }
}
