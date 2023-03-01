import Dependencies
import Foundation
import NetworkClientExtensions
import RequestBuilder

extension RocketsClient: DependencyKey {
  public static var liveValue: Self {
    @Dependency(\.networkClientType) var networkClientType

    return Self(
      getRocket: { id in
        Request(endpoint: URLs.baseURL + "/v3/rockets/\(id)").execute(using: networkClientType)
          // TODO: Avoid ignoring the error by using ErrorReporting.
          .ignoreFailure(setFailureType: RocketNetworkError.self)
      },
      getAllRockets: {
        Request(endpoint: URLs.baseURL + "/v3/rockets").execute(using: networkClientType)
          // TODO: Avoid ignoring the error by using ErrorReporting.
          .ignoreFailure(setFailureType: RocketNetworkError.self)
      }
    )
  }
}
