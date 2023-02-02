import Combine
@testable import RocketsClient
import XCTest

final class RocketsClientTests: XCTestCase {
  func testRocketLiveData() {
    var subscriptions = Set<AnyCancellable>()
    var rocketData: RocketDetail?
    var receivedValue: Int = 0
    var receivedCompletion = false

    let exp = expectation(description: "")
    exp.expectedFulfillmentCount = 1

    RocketsClient.live.getRocket("falcon1")
      .sink(
        receiveCompletion: { _ in
          receivedCompletion = true
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
    XCTAssert(receivedCompletion)
    XCTAssertEqual(rocketData?.id, "falcon1")
    XCTAssertEqual(rocketData?.name, "Falcon 1")
    XCTAssertEqual(rocketData?.height.meters, 22.25)
    XCTAssertEqual(rocketData?.diameter.meters, 1.68)
    XCTAssertEqual(rocketData?.mass.kilograms, 30146)
    XCTAssertEqual(rocketData?.firstStage.burnTime, 169)
    XCTAssertEqual(rocketData?.secondStage.burnTime, 378)
    XCTAssertEqual(rocketData?.firstFlight, "2006-03-24")
  }

  func testRocketsLiveData() {
    var subscriptions = Set<AnyCancellable>()
    var rocketData: [RocketDetail] = []
    var receivedValue: Int = 0
    var receivedCompletion = false

    let exp = expectation(description: "")
    exp.expectedFulfillmentCount = 1

    RocketsClient.live.getAllRockets()
      .sink(
        receiveCompletion: {
          print("cojeee \($0)")
          receivedCompletion = true
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
    XCTAssert(receivedCompletion)
    XCTAssertEqual(rocketData.count, 4)
    XCTAssertEqual(rocketData[0].name, "Falcon 1")
    XCTAssertEqual(rocketData[1].name, "Falcon 9")
    XCTAssertEqual(rocketData[2].name, "Falcon Heavy")
    XCTAssertEqual(rocketData[3].name, "Starship")
  }

  func testRocketMockData() {
    var subscriptions = Set<AnyCancellable>()
    var rocketData: RocketDetail?
    var receivedValue: Int = 0
    var receivedCompletion = false

    let exp = expectation(description: "")
    exp.expectedFulfillmentCount = 1

    RocketsClient.mock.getRocket("")
      .sink(
        receiveCompletion: { _ in
          receivedCompletion = true
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
    XCTAssert(receivedCompletion)
    XCTAssertEqual(rocketData?.id, "apollo13")
    XCTAssertEqual(rocketData?.name, "Apollo 13")
    XCTAssertEqual(rocketData?.height.meters, 130)
    XCTAssertEqual(rocketData?.diameter.meters, 20.2)
    XCTAssertEqual(rocketData?.mass.kilograms, 150)
    XCTAssertEqual(rocketData?.firstStage.burnTime, 162)
    XCTAssertEqual(rocketData?.secondStage.burnTime, 162)
    XCTAssertEqual(rocketData?.firstFlight, "1991-03-09")
  }
}
