import Combine
import Dependencies
import Foundation
import Networking

public struct RocketsClient {
  public typealias GetRocketFunction = (String) -> AnyPublisher<RocketDetail, NetworkError>
  public typealias GetAllRocketsFunction = () -> AnyPublisher<[RocketDetail], NetworkError>

  public var getRocket: GetRocketFunction
  public var getAllRockets: GetAllRocketsFunction
}

enum RocketsClientKey: DependencyKey {
  public static var liveValue: RocketsClient = .liveValue
  #if DEBUG
  public static var testValue: RocketsClient = .testValue
  #endif
}

extension DependencyValues {
  var rocketsClient: RocketsClient {
    get { self[RocketsClientKey.self] }
    set { self[RocketsClientKey.self] = newValue }
  }
}
