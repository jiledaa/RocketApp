import Dependencies
import Foundation
import Networking

extension NetworkClient: DependencyKey {
  public static var liveValue = NetworkClient(
    urlSessionConfiguration: .default,
    urlRequester: .live,
    networkMonitorClient: .live(onQueue: .main)
  )
}
