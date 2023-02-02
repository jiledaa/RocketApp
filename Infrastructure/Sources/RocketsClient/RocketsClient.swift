import Combine
import Foundation
import GeneralToolkit
import Networking

public struct RocketsClient {
  public var getRocket: (String) -> AnyPublisher<RocketDetail, NetworkError>
  public var getAllRockets: () -> AnyPublisher<[RocketDetail], NetworkError>
}

public extension RocketsClient {
  static let live: RocketsClient = RocketsClient(
    getRocket: { id in
      guard let url = URL(string: URLs.rocket(id: id)) else {
        return Fail(error: .urlError(URLError(.badURL)))
          .eraseToAnyPublisher()
      }

      let urlRequest = URLRequest(url: url)

      return NetworkClient
        .live(networkMonitorQueue: .main)
        .request(urlRequest)
    },
    getAllRockets: {
      guard let url = URL(string: URLs.allRockets) else {
        return Fail(error: .urlError(URLError(.badURL)))
          .eraseToAnyPublisher()
      }

      let urlRequest = URLRequest(url: url)

      return NetworkClient
        .live(networkMonitorQueue: .main)
        .request(urlRequest)
    }
  )

  static let mock: RocketsClient = RocketsClient(
    getRocket: { _ in
      Just(RocketDetail.mock)
        .setFailureType(to: NetworkError.self)
        .eraseToAnyPublisher()
    },
    getAllRockets: {
      Just([RocketDetail.mock])
        .setFailureType(to: NetworkError.self)
        .eraseToAnyPublisher()
    }
  )
}
