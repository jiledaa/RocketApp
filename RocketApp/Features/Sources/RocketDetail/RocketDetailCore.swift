import ComposableArchitecture
import Foundation
import RocketsClient

public struct RocketDetailCore: ReducerProtocol {
  public struct State: Equatable {
    public var rocketData: RocketDetail

    public init(rocketData: RocketDetail) {
      self.rocketData = rocketData
    }
  }

  public enum Action: Equatable {

  }

  public init() {}

  @Dependency(\.rocketsClient) var rocketsClient

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {

      }
    }
  }
}
