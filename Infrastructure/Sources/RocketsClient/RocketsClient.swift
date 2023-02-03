import Combine
import Foundation
import Networking

public struct RocketsClient {
  public var getRocket: (String) -> AnyPublisher<RocketDetail, NetworkError>
  public var getAllRockets: () -> AnyPublisher<[RocketDetail], NetworkError>
}
