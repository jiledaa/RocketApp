import Foundation
import RocketsClient
import ComposableArchitecture

public struct RocketListCellCore: ReducerProtocol {
  public struct State: Equatable, Identifiable {
    public var rocketData: RocketDetail
    public var id: String { rocketData.id }

    public init(rocketData: RocketDetail) {
      self.rocketData = rocketData
    }
  }

  public enum Action: Equatable {
    case cellTapped
  }

  public init() {}

  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .cellTapped:
        return .none
      }
    }
  }
}
