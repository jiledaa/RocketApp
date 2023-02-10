import Combine
import Foundation
import Networking

public extension RocketsClient {
  static let previewValue = Self(
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
