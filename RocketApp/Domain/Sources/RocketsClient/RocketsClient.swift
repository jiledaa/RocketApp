import Combine
import Foundation

public struct RocketsClient {
  public typealias GetRocketFunction = (String) -> AnyPublisher<RocketDetail, RocketsClientError>
  public typealias GetAllRocketsFunction = () -> AnyPublisher<[RocketDetail], RocketsClientError>

  public var getRocket: GetRocketFunction
  public var getAllRockets: GetAllRocketsFunction
}
