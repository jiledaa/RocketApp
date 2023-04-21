import Dependencies
import ErrorReporting
import Foundation
import NetworkClientExtensions
import Networking
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
          .mapErrorReporting(to: RocketsClientError.networkError)
          .convertToDomainModel(using: rocketConverter)
          .eraseToAnyPublisher()
      },
      getAllRockets: {
        Request(endpoint: URLs.baseURL + "/v3/rockets")
          .execute(using: networkClientType)
          .mapErrorReporting(to: RocketsClientError.networkError)
          .convertToDomainModel(using: rocketsConverter)
          .eraseToAnyPublisher()
      }
    )
  }
}
