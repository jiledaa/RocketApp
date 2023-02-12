import Dependencies
import Foundation
import Networking

extension DependencyValues {
  var networkClientType: NetworkClientType {
    get { self[NetworkClientKey.self] }
    set { self[NetworkClientKey.self] = newValue }
  }

  var rocketsClient: RocketsClient {
    get { self[RocketsClientKey.self] }
    set { self[RocketsClientKey.self] = newValue }
  }
}
