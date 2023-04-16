import Combine
import Dependencies
import Foundation
import NetworkClientExtensions
import RequestBuilder

public extension RocketsClient {
  static var live: Self {
    @Dependency(\.networkClientType) var networkClientType
    @Dependency(\.rocketConverter) var rocketConverter
    @Dependency(\.rocketsConverter) var rocketsConverter

    return Self(
      getRocket: { id in
        Request(endpoint: URLs.baseURL + "/v3/rockets/\(id)")
          .execute(using: networkClientType)
          .convertToDomainModel(using: rocketConverter)
          .mapError { RocketNetworkError(networkError: $0.cause) }
          .eraseToAnyPublisher()
      },
      getAllRockets: {
        Request(endpoint: URLs.baseURL + "/v3/rockets")
          .execute(using: networkClientType)
          .convertToDomainModel(using: rocketsConverter)
          .mapError { RocketNetworkError(networkError: $0.cause) }
          .eraseToAnyPublisher()
      }
    )
  }
}
