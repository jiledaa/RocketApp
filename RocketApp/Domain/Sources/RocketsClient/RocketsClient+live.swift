import Dependencies
import ErrorReporting
import Foundation
import NetworkClientExtensions
import Networking
import RequestBuilder

public extension RocketsClient {
  static var liveReact: Self {
    @Dependency(\.networkClientType) var networkClientType
    @Dependency(\.rocketConverter) var rocketConverter
    @Dependency(\.rocketsConverter) var rocketsConverter

    return Self(
      getRocket: { id in
        try await Request(endpoint: URLs.baseURL + "/v3/rockets/\(id)")
          .execute(using: networkClientType)
          .mapErrorReporting(to: RocketsClientError.networkError)
          .convertToDomainModel(using: rocketConverter)
          .eraseToAnyPublisher()
          .async()
      },
      getAllRockets: {
        try await Request(endpoint: URLs.baseURL + "/v3/rockets")
          .execute(using: networkClientType)
          .mapErrorReporting(to: RocketsClientError.networkError)
          .convertToDomainModel(using: rocketsConverter)
          .eraseToAnyPublisher()
          .async()
      }
    )
  }

  static var liveAsync: Self {
    @Dependency(\.networkClientType) var networkClientType
    @Dependency(\.rocketConverter) var rocketConverter
    @Dependency(\.rocketsConverter) var rocketsConverter

    return Self(
      getRocket: { id in
        var data: RocketDetailDTO
        do {
            data = try await Request(endpoint: URLs.baseURL + "/v3/rockets/\(id)")
              .execute(using: networkClientType)
        } catch let error {
          guard let networkError = error as? NetworkError else {
            throw error
          }

          throw RocketsClientAsyncError.networkError(networkError)
        }

        guard let result = rocketConverter.domainModel(fromExternal: data) else {
          throw RocketsClientError.modelConvertibleError
        }

        return result
      },
      getAllRockets: {
        var data: [RocketDetailDTO]
        do {
          data = try await Request(endpoint: URLs.baseURL + "/v3/rockets/")
            .execute(using: networkClientType)
        } catch let error {
          guard let networkError = error as? NetworkError else {
            throw error
          }

          throw RocketsClientAsyncError.networkError(networkError)
        }

        guard let result = rocketsConverter.domainModel(fromExternal: data) else {
          throw RocketsClientAsyncError.modelConversionError
        }

        return result
      }
    )
  }
}
