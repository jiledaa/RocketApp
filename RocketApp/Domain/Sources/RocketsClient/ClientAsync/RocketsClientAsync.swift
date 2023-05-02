import Foundation

public struct RocketsClientAsync {
  public typealias GetRocketFunction = (String) async throws -> RocketDetail
  public typealias GetAllRocketsFunction = () async throws -> [RocketDetail]

  public var getRocket: GetRocketFunction
  public var getAllRockets: GetAllRocketsFunction
}
