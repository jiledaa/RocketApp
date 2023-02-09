import Combine
import Foundation
import Networking

public struct RocketsClient {
  public typealias GetRocketFunction = (String) -> AnyPublisher<RocketDetail, NetworkError>
  public typealias GetAllRocketsFunction = () -> AnyPublisher<[RocketDetail], NetworkError>

  public var getRocket: GetRocketFunction
  public var getAllRockets: GetAllRocketsFunction
}
