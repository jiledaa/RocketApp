import Combine
import Foundation
import Networking

public extension RocketsClient {
  static let live: RocketsClient = RocketsClient(
    getRocket: { id in
      guard let url = URL(string: URLs.baseURL + "/v3/rockets/\(id)") else {
        return Fail(error: .urlError(URLError(.badURL)))
          .eraseToAnyPublisher()
      }

      let urlRequest = URLRequest(url: url)

      return NetworkClient
        .live(networkMonitorQueue: .main)
        .request(urlRequest)
    },
    getAllRockets: {
      guard let url = URL(string: URLs.baseURL + "/v3/rockets") else {
        return Fail(error: .urlError(URLError(.badURL)))
          .eraseToAnyPublisher()
      }

      let urlRequest = URLRequest(url: url)

      return NetworkClient
        .live(networkMonitorQueue: .main)
        .request(urlRequest)
    }
  )
}
