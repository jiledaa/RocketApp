import Foundation
import RocketsClient
import ComposableArchitecture

struct RocketListCellCore: ReducerProtocol {
  public struct State: Equatable {
    var rocketDetail: RocketDetail

    public init(rocketDetail: RocketDetail) {
      self.rocketDetail = rocketDetail
    }
  }

  public enum Action: Equatable {
    case cellTapped
  }

  public init() {}

  @Dependency(\.rocketsClient) var rocketsClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .cellTapped:
        return .none
      }
    }
  }
}
