import Combine
import Dependencies
@testable import Networking
import RequestBuilder
@testable import RocketsClient
import XCTest

struct NetworkClientMock: NetworkClientType {
  var request: (_ urlRequest: URLRequest) -> AnyPublisher<(headers: [HTTPHeader], body: Data), NetworkError>

  func request(_ urlRequest: URLRequest) -> AnyPublisher<(headers: [HTTPHeader], body: Data), NetworkError> {
    request(urlRequest)
  }
}

final class RocketsClientErrorTests: XCTestCase {
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

  func test_rocket_model_conversion_failure() {
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

    let modelConversionError = RocketsClientError.modelConvertibleError

    withDependencies {
      $0.networkClientType = setNetworkClient(requester: requesterMock)
      $0.rocketConverter = .init(domainModelConverter: { _ in nil })
    } operation: {
      RocketsClient.live.getRocket("")
        .sink(
          receiveCompletion: {
            switch $0 {
            case let .failure(error):
              XCTAssertEqual(error.cause, modelConversionError.cause)
              exp.fulfill()
            case .finished:
              XCTFail("Unexpected success.")
            }
          },
          receiveValue: { XCTAssertNil($0) }
        )
        .store(in: &subscriptions)

      wait(for: [exp], timeout: 0.1)
    }
  }

  func test_rockets_model_conversion_failure() {
    let exp = expectation(description: "")

    // swiftlint:disable:next force_try
    let dataMock = try! JSONEncoder().encode(RocketDetailDTO.mocks)
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

    let modelConversionError = RocketsClientError.modelConvertibleError

    withDependencies {
      $0.networkClientType = setNetworkClient(requester: requesterMock)
      $0.rocketsConverter = .init(domainModelConverter: { _ in nil })
    } operation: {
      RocketsClient.live.getAllRockets()
        .sink(
          receiveCompletion: {
            switch $0 {
            case let .failure(error):
              XCTAssertEqual(error.cause, modelConversionError.cause)
              exp.fulfill()
            case .finished:
              XCTFail("Unexpected success.")
            }
          },
          receiveValue: { XCTAssertNil($0) }
        )
        .store(in: &subscriptions)

      wait(for: [exp], timeout: 0.1)
    }
  }

  func test_rocket_network_failure() {
    let exp = expectation(description: "")

    let networkClient = NetworkClientMock { _ in
      Fail<(headers: [HTTPHeader], body: Data), NetworkError>(error: NetworkError.noConnection)
        .eraseToAnyPublisher()
    }

    let networkError = RocketsClientError.networkError

    withDependencies {
      $0.networkClientType = networkClient
    } operation: {
      RocketsClient.live.getRocket("")
        .sink(
          receiveCompletion: {
            switch $0 {
            case let .failure(error):
              XCTAssertEqual(error.cause, networkError.cause)
              exp.fulfill()
            case .finished:
              XCTFail("Unexpected success.")
            }
          },
          receiveValue: { XCTAssertNil($0) }
        )
        .store(in: &subscriptions)

      wait(for: [exp], timeout: 0.1)
    }
  }

  func test_rockets_network_failure() {
    let exp = expectation(description: "")

    let networkClient = NetworkClientMock { _ in
      Fail<(headers: [HTTPHeader], body: Data), NetworkError>(error: NetworkError.noConnection)
        .eraseToAnyPublisher()
    }

    let networkError = RocketsClientError.networkError

    withDependencies {
      $0.networkClientType = networkClient
    } operation: {
      RocketsClient.live.getAllRockets()
        .sink(
          receiveCompletion: {
            switch $0 {
            case let .failure(error):
              XCTAssertEqual(error.cause, networkError.cause)
              exp.fulfill()
            case .finished:
              XCTFail("Unexpected success.")
            }
          },
          receiveValue: { XCTAssertNil($0) }
        )
        .store(in: &subscriptions)

      wait(for: [exp], timeout: 0.1)
    }
  }
}
