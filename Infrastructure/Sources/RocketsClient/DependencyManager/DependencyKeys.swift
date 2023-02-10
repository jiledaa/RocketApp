import Dependencies
import Foundation
import Networking

enum RocketClientKey: DependencyKey {
  public static var liveValue: RocketsClient = .liveValue
  #if DEBUG
  public static var testValue: RocketsClient = .testValue
  #endif
}

enum NetworkClientKey: DependencyKey {
  public static var liveValue: NetworkClientType = NetworkClient.live
}
