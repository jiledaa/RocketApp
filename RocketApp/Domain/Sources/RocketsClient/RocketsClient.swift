import Combine
import Foundation
import NetworkClientExtensions

public struct RocketsClient {
  public typealias GetRocketFunction = (String) -> AnyPublisher<RocketDetail, RocketNetworkError>
  public typealias GetAllRocketsFunction = () -> AnyPublisher<[RocketDetail], RocketNetworkError>

  public var getRocket: GetRocketFunction
  public var getAllRockets: GetAllRocketsFunction
}
