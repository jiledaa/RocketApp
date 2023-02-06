import Foundation
import Networking
import RequestBuilder

public extension RocketsClient {
  static func live(_ networking: NetworkClientType) -> RocketsClient {
    RocketsClient(
      getRocket: { id in
        let request = Request(endpoint: URLs.baseURL + "/v3/rockets/\(id)")

        return request.execute(using: networking)
      },
      getAllRockets: {
        let request = Request(endpoint: URLs.baseURL + "/v3/rockets")

        return request.execute(using: networking)
      }
    )
  }
}
