import Combine
@testable import RocketsClient
import XCTest

final class RocketsClientTests: XCTestCase {
  func test_rocket_live_data() {
    var subscriptions = Set<AnyCancellable>()
    var rocketData: RocketDetail?
    var receivedValue: Int = 0

    let exp = expectation(description: "")

    RocketsClient.live.getRocket("falcon1")
      .sink(
        receiveCompletion: { _ in
          exp.fulfill()
        },
        receiveValue: {
          rocketData = $0
          receivedValue += 1
        }
      )
      .store(in: &subscriptions)

    wait(for: [exp], timeout: 5)
    XCTAssertEqual(receivedValue, 1)
    XCTAssertEqual(rocketData?.id, "falcon1")
    XCTAssertEqual(rocketData?.name, "Falcon 1")
    XCTAssertEqual(rocketData?.height.meters, 22.25)
    XCTAssertEqual(rocketData?.diameter.meters, 1.68)
    XCTAssertEqual(rocketData?.mass.kilograms, 30_146)
    XCTAssertEqual(rocketData?.firstStage.burnTime, 169)
    XCTAssertEqual(rocketData?.secondStage.burnTime, 378)
    XCTAssertEqual(rocketData?.firstFlight, "2006-03-24")
  }

  func test_rockets_live_data() {
    var subscriptions = Set<AnyCancellable>()
    var rocketData: [RocketDetail] = []
    var receivedValue: Int = 0

    let exp = expectation(description: "")
    exp.expectedFulfillmentCount = 1

    RocketsClient.live.getAllRockets()
      .sink(
        receiveCompletion: { _ in
          exp.fulfill()
        },
        receiveValue: {
          rocketData = $0
          receivedValue += 1
        }
      )
      .store(in: &subscriptions)

    wait(for: [exp], timeout: 5)
    XCTAssertEqual(receivedValue, 1)
    XCTAssertEqual(rocketData.count, 4)
    XCTAssertEqual(rocketData[0].name, "Falcon 1")
    XCTAssertEqual(rocketData[1].name, "Falcon 9")
    XCTAssertEqual(rocketData[2].name, "Falcon Heavy")
    XCTAssertEqual(rocketData[3].name, "Starship")
  }
}
