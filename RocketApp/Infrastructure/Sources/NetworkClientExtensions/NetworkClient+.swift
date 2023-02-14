import Dependencies
import Foundation
import Networking
import XCTestDynamicOverlay

extension NetworkClient: DependencyKey {
  public static var liveValue = NetworkClient(
    urlSessionConfiguration: .default,
    urlRequester: .live,
    networkMonitorClient: .live(onQueue: .main)
  )

  public static var testValue = Self(
    urlSessionConfiguration: unimplemented("\(Self.self).urlSessionConfiguration"),
    urlRequester: unimplemented("\(Self.self).urlRequester"),
    networkMonitorClient: unimplemented("\(Self.self).networkMonitorClient")
  )
}
