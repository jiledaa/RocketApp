import Combine
import Foundation
import NetworkClientExtensions

public extension RocketsClient {
  static let previewValue = Self(
    getRocket: { _ in
      Just(RocketDetail.mock)
        .setFailureType(to: RocketNetworkError.self)
        .eraseToAnyPublisher()
    },
    getAllRockets: {
      Just([RocketDetail.mock])
        .setFailureType(to: RocketNetworkError.self)
        .eraseToAnyPublisher()
    }
  )
}
