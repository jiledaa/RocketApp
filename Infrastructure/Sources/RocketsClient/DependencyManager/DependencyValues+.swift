import Dependencies
import Foundation
import Networking

extension DependencyValues {
  var networkClientType: NetworkClientType {
    get { self[NetworkClientKey.self] }
    set { self[NetworkClientKey.self] = newValue }
  }

  var rocketClient: RocketsClient {
    get { self[RocketClientKey.self] }
    set { self[RocketClientKey.self] = newValue }
  }
}
