import Foundation
import Networking

public extension NetworkClient {
  static var live = NetworkClient(
    urlSessionConfiguration: .default,
    urlRequester: .live,
    networkMonitorClient: .live(onQueue: .main)
  )
}
