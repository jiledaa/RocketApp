import Combine
import Foundation

public extension RocketsClient {
  static let preview = Self(
    getRocket: { _ in
      Just(RocketDetail.mock)
        .setFailureType(to: RocketsClientError.self)
        .eraseToAnyPublisher()
    },
    getAllRockets: {
      Just([RocketDetail.mock])
        .setFailureType(to: RocketsClientError.self)
        .eraseToAnyPublisher()
    }
  )
}
