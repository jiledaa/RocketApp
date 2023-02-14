import Dependencies
import Foundation
import Networking

public extension DependencyValues {
    var networkClientType: NetworkClientType {
      get { self[NetworkClientKey.self] }
      set { self[NetworkClientKey.self] = newValue }
    }
}
