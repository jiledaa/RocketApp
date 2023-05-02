import Foundation

public extension RocketsClientAsync {
  static let preview = Self(
    getRocket: { _ in RocketDetail.mock },
    getAllRockets: { [RocketDetail.mock] }
  )
}
