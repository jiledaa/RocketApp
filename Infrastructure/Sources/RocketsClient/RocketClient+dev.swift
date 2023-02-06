import Combine
import Foundation
import Networking

extension RocketsClient {
  static var dev: RocketsClient = RocketsClient(
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
