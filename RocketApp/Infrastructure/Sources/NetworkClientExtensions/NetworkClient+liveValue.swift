import Dependencies
import Foundation
import Networking

extension NetworkClient: DependencyKey {
  public static var liveValue = NetworkClient(
    urlRequester: .live(urlSessionConfiguration: .default),
    networkMonitorClient: .live(onQueue: .main)
  )
}
