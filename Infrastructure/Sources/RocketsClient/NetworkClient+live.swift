import Foundation
import Networking

public extension NetworkClient {
  static func live(
    networkMonitorQueue queue: DispatchQueue,
    urlRequester: URLRequester = .live
  ) -> NetworkClientType {
    NetworkClient(
      urlSessionConfiguration: URLSessionConfiguration.default,
      urlRequester: urlRequester,
      networkMonitorClient: .live(onQueue: queue)
    )
  }
}
