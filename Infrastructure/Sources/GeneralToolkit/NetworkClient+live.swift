//
//  File.swift
//  
//
//  Created by David Jilek on 02.02.2023.
//
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
