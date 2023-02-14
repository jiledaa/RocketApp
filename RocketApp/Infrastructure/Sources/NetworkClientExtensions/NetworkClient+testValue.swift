import Foundation
import Networking
import XCTestDynamicOverlay

extension NetworkClient {
  public static var testValue = Self(
    urlSessionConfiguration: unimplemented("\(Self.self).urlSessionConfiguration"),
    urlRequester: unimplemented("\(Self.self).urlRequester"),
    networkMonitorClient: unimplemented("\(Self.self).networkMonitorClient")
  )
}
