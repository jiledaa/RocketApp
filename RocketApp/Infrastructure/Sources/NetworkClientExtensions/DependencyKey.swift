import Dependencies
import Foundation
import Networking

enum NetworkClientKey: DependencyKey {
  public static var liveValue: NetworkClientType = NetworkClient.liveValue
  public static var testValue: NetworkClientType = NetworkClient.testValue
}
