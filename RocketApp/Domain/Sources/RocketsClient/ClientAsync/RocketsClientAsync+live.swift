import Combine
import Dependencies
import ErrorReporting
import Foundation
import ModelConvertible
import NetworkClientExtensions
import Networking
import RequestBuilder

public extension RocketsClientAsync {
  static var live: Self {
    @Dependency(\.networkClientType) var networkClientType
    @Dependency(\.rocketConverter) var rocketConverter
    @Dependency(\.rocketsConverter) var rocketsConverter

    return Self(
      getRocket: { id in
        var data: RocketDetailDTO
//        do {
            data = try await Request(endpoint: URLs.baseURL + "/v3/rockets/\(id)")
              .execute(using: networkClientType)
//        } catch {
//            throw RocketsClientError.networkError
//        }

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
        } catch {
          throw RocketsClientError.networkError
        }

        guard let result = rocketsConverter.domainModel(fromExternal: data) else {
          throw RocketsClientError.modelConvertibleError
        }

        return result
//        try await Request(endpoint: URLs.baseURL + "/v3/rockets")
//          .execute(using: networkClientType)
//          .convertToDomainModel(using: rocketsConverter)
//          .async()
      }
    )
  }
}

//extension TaskResult<Model> where Success == Model, Failure == RocketsClientError {
//
//}

extension Result where Success == URLRequest, Failure == URLRequestError {
  var networkPublisher: AnyPublisher<URLRequest, NetworkError> {
    self.publisher
      .mapErrorReporting(to: .urlRequestBuilderError)
      .eraseToAnyPublisher()
  }

  func execute<DataModel, FetcherError: ErrorReporting, ResultError: ErrorReporting & NetworkErrorCapable>(
    fetcher: @escaping (URLRequest) -> AnyPublisher<DataModel, FetcherError>,
    mapNetworkError: ((FetcherError) -> ResultError)? = nil
  ) -> AnyPublisher<DataModel, ResultError> {
    networkPublisher
      .mapErrorReporting(to: ResultError.networkError)
      .flatMap { urlRequest in
        fetcher(urlRequest)
          .catch { error -> AnyPublisher<DataModel, ResultError> in
            if let mapNetworkError = mapNetworkError {
              return Fail<DataModel, ResultError>(error: mapNetworkError(error))
                .eraseToAnyPublisher()
            }

            return Fail(error: error)
              .mapErrorReporting(to: ResultError.networkError)
              .eraseToAnyPublisher()
          }
      }
      .eraseToAnyPublisher()
  }

  func execute<T: Decodable, ResultError: ErrorReporting & NetworkErrorCapable>(
    using networkClient: NetworkClientType,
    jsonDecoder: JSONDecoder = JSONDecoder(),
    mapNetworkError: ((NetworkError) -> ResultError)? = nil
  ) async throws -> T {
    try await execute(
      fetcher: { networkClient.request($0, jsonDecoder: jsonDecoder) },
      mapNetworkError: mapNetworkError
    )
    .async()
  }
}
