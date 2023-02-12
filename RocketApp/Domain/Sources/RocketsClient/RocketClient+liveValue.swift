import Dependencies
import Foundation
import Networking
import RequestBuilder

extension RocketsClient: DependencyKey {
  public static var liveValue: Self {
    @Dependency(\.networkClientType) var networkClientType

    return Self(
      getRocket: { id in
        Request(endpoint: URLs.baseURL + "/v3/rockets/\(id)").execute(using: networkClientType)
      },
      getAllRockets: {
        Request(endpoint: URLs.baseURL + "/v3/rockets").execute(using: networkClientType)
      }
    )
  }
}
