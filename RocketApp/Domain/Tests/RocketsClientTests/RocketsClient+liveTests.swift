import Combine
import Dependencies
@testable import Networking
@testable import RocketsClient
import XCTest

final class RocketsClientLiveTests: XCTestCase {
  private var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    super.tearDown()

    subscriptions = []
  }

  private func setNetworkClient(requester: URLRequester) -> NetworkClient {
      NetworkClient(
        urlRequester: requester,
        networkMonitorClient: .live(onQueue: .main)
      )
  }

  func test_rocket_request_success() {
    var rocketData: RocketDetail?
    var receivedValueCount: Int = 0
    let exp = expectation(description: "")

    // swiftlint:disable:next force_try
    let dataMock = try! JSONEncoder().encode(RocketDetailDTO.mock)
    let responseMock = HTTPURLResponse(
      url: URL(string: "www.google.com")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: [:]
    )!
    let requesterMock = URLRequester { _ in
      Just((dataMock, responseMock))
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    }

    withDependencies {
      $0.networkClientType = setNetworkClient(requester: requesterMock)
      $0.lineMeasureConverter = .live
      $0.weightScaleConverter = .live
      $0.stageConverter = .live
      $0.rocketConverter = .live
    } operation: {
      RocketsClient.live.getRocket("")
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
  }

  func test_rocket_request_failure() {
    let exp = expectation(description: "")

    let requesterMock = URLRequester { _ in
      Fail(error: URLError(.badServerResponse))
        .eraseToAnyPublisher()
    }

    withDependencies {
      $0.networkClientType = setNetworkClient(requester: requesterMock)
    } operation: {
      RocketsClient.live.getRocket("")
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

  func test_rockets_request_success() {
    var rocketData: [RocketDetail] = []
    var receivedValueCount: Int = 0
    let exp = expectation(description: "")

    // swiftlint:disable:next force_try
    let dataMock = try! JSONEncoder().encode([RocketDetailDTO.mock])
    let responseMock = HTTPURLResponse(
      url: URL(string: "www.google.com")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: [:]
    )!
    let requesterMock = URLRequester { _ in
      Just((dataMock, responseMock))
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    }

    withDependencies {
      $0.networkClientType = setNetworkClient(requester: requesterMock)
      $0.lineMeasureConverter = .live
      $0.weightScaleConverter = .live
      $0.stageConverter = .live
      $0.rocketConverter = .live
      $0.rocketsConverter = .live
    } operation: {
      RocketsClient.live.getAllRockets()
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
  }

  func test_rockets_request_failure() {
    let exp = expectation(description: "")

    let requesterMock = URLRequester { _ in
      Fail(error: URLError(.badServerResponse))
        .eraseToAnyPublisher()
    }

    withDependencies {
      $0.networkClientType = setNetworkClient(requester: requesterMock)
    } operation: {
      RocketsClient.live.getAllRockets()
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
}
