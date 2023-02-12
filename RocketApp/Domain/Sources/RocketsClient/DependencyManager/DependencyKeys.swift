import Dependencies
import Foundation
import Networking

enum RocketsClientKey: DependencyKey {
  public static var liveValue: RocketsClient = .liveValue
  #if DEBUG
  public static var testValue: RocketsClient = .testValue
  #endif
}

enum NetworkClientKey: DependencyKey {
  public static var liveValue: NetworkClientType = NetworkClient.liveValue
  public static var testValue: NetworkClientType = NetworkClient.testValue
}
