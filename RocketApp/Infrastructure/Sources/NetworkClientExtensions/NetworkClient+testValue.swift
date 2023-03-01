#if DEBUG
import Foundation
import Networking
import XCTestDynamicOverlay

public extension NetworkClient {
  static var testValue = Self(
    urlRequester: unimplemented("\(Self.self).urlRequester"),
    networkMonitorClient: unimplemented("\(Self.self).networkMonitorClient")
  )
}
#endif
