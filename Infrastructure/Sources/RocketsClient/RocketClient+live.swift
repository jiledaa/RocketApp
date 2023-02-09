import Foundation
import Networking
import RequestBuilder

public extension RocketsClient {
  static func live(_ networking: NetworkClientType) -> RocketsClient {
    RocketsClient(
      getRocket: { id in
        Request(endpoint: URLs.baseURL + "/v3/rockets/\(id)").execute(using: networking)
      },
      getAllRockets: {
        Request(endpoint: URLs.baseURL + "/v3/rockets").execute(using: networking)
      }
    )
  }
}
