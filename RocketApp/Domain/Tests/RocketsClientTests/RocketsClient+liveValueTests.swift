import Combine
import Dependencies
@testable import Networking
@testable import RocketsClient
import XCTest

final class UnitTests: XCTestCase {
  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    super.tearDown()

    subscriptions = []
  }

  private func rocketsClient(requester: URLRequester) -> RocketsClient {
    withDependencies {
      $0.networkClientType = NetworkClient(
        urlSessionConfiguration: .default,
        urlRequester: requester,
        networkMonitorClient: .live(onQueue: .main)
      )
    } operation: {
      return RocketsClient.liveValue
    }
  }

  func test_rocket_request_success() {
    var rocketData: RocketDetail?
    var receivedValueCount: Int = 0
    let exp = expectation(description: "")

    // swiftlint:disable:next force_try
    let dataMock = try! JSONEncoder().encode(RocketDetail.mock)
    let responseMock = HTTPURLResponse(
      url: URL(string: "www.google.com")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: [:]
    )!
    let requesterMock = URLRequester { _ in { _ in
      Just((dataMock, responseMock))
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    }
    }

    rocketsClient(requester: requesterMock).getRocket("")
      .sink(
        receiveCompletion: {
          switch $0 {
          case .failure:
            XCTFail("Unexpected failure.")
          case .finished:
            exp.fulfill()
          }
        },
        receiveValue: {
          rocketData = $0
          receivedValueCount += 1
        }
      )
      .store(in: &subscriptions)

    wait(for: [exp], timeout: 0.1)
    XCTAssertEqual(rocketData?.id, "apollo13")
    XCTAssertEqual(receivedValueCount, 1)
  }

  func test_rocket_request_failure() {
    let exp = expectation(description: "")

    let requesterMock = URLRequester { _ in { _ in
      Fail(error: URLError(.badServerResponse))
        .eraseToAnyPublisher()
    }
    }

    rocketsClient(requester: requesterMock).getRocket("")
      .sink(
        receiveCompletion: {
          switch $0 {
          case .failure:
            exp.fulfill()
          case .finished:
            XCTFail("Unexpected event - finished.")
          }
        },
        receiveValue: {
          XCTFail("Unexpected value - \($0).")
        }
      )
      .store(in: &subscriptions)

    wait(for: [exp], timeout: 5)
  }

  func test_rockets_request_success() {
    var rocketData: [RocketDetail] = []
    var receivedValueCount: Int = 0
    let exp = expectation(description: "")

    // swiftlint:disable:next force_try
    let dataMock = try! JSONEncoder().encode([RocketDetail.mock])
    let responseMock = HTTPURLResponse(
      url: URL(string: "www.google.com")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: [:]
    )!
    let requesterMock = URLRequester { _ in { _ in
      Just((dataMock, responseMock))
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    }
    }

    rocketsClient(requester: requesterMock).getAllRockets()
      .sink(
        receiveCompletion: {
          switch $0 {
          case .failure:
            XCTFail("Unexpected failure.")
          case .finished:
            exp.fulfill()
          }
        },
        receiveValue: {
          rocketData = $0
          receivedValueCount += 1
        }
      )
      .store(in: &subscriptions)

    wait(for: [exp], timeout: 0.1)
    XCTAssertEqual(rocketData[0].id, "apollo13")
    XCTAssertEqual(receivedValueCount, 1)
  }

  func test_rockets_request_failure() {
    let exp = expectation(description: "")

    let requesterMock = URLRequester { _ in { _ in
      Fail(error: URLError(.badServerResponse))
        .eraseToAnyPublisher()
    }
    }

    rocketsClient(requester: requesterMock).getAllRockets()
      .sink(
        receiveCompletion: {
          switch $0 {
          case .failure:
            exp.fulfill()
          case .finished:
            XCTFail("Unexpected event - finished.")
          }
        },
        receiveValue: {
          XCTFail("Unexpected value - \($0).")
        }
      )
      .store(in: &subscriptions)

    wait(for: [exp], timeout: 5)
  }
}
