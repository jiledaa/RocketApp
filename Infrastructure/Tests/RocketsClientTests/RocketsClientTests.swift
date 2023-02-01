@testable import RocketsClient
import XCTest

final class RocketsClientTests: XCTestCase {
  let testAPIFactory = ApiFactory { _ in
    try await Task.sleep(nanoseconds: NSEC_PER_SEC)

    return ("1".data(using: .utf8)!, URLResponse())
  }

  let failingTestAPIFactory = ApiFactory { _ in
    try await Task.sleep(nanoseconds: NSEC_PER_SEC)

    throw APIError.badURL
  }

  func testGetDataSuccess() async {
    let expectation = XCTestExpectation()
    var one: Int?

    do {
      one = try await self.testAPIFactory.getData(from: "google.com")
      expectation.fulfill()
    } catch {
      XCTFail("Unexpected failure.")
    }

    wait(for: [expectation], timeout: TimeInterval(1))
    XCTAssertEqual(one, 1)
  }

  func testGetDataFailure() async {
    let expectation = XCTestExpectation()

    do {
      let _: Int = try await self.failingTestAPIFactory.getData(from: "google.com")
      XCTFail("Unexpected success.")
    } catch {
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: TimeInterval(1))
  }
}
