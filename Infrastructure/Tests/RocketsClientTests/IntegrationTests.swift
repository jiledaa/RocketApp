import Combine
import Networking
@testable import RocketsClient
import XCTest

final class RocketsClientTests: XCTestCase {
//  var networkClient: NetworkClientType!
//  var requesterMock: URLRequester!
//  var rocketsClient: RocketsClient!

  var subscriptions = Set<AnyCancellable>()

  override func setUp() {
    super.setUp()

//    networkClient = NetworkClient(
//      urlSessionConfiguration: .default,
//      urlRequester: .live,
//      networkMonitorClient: .live(onQueue: .main)
//    )
//
//    rocketsClient = RocketsClient.live(networkClient)
  }

  override func tearDown() {
    super.tearDown()

    subscriptions = []
//    networkClient = nil
  }
}
