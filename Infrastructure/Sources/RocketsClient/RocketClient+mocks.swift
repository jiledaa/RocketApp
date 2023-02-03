import Combine
import Foundation
import Networking

extension RocketsClient {
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
