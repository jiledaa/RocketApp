#if DEBUG
import Dependencies
import Foundation
import XCTestDynamicOverlay

extension RocketsClient {
  public static var testValue = Self(
    getRocket: unimplemented("\(Self.self).getRocket"),
    getAllRockets: unimplemented("\(Self.self).getAllRockets")
  )

  static func testValue(
    getRocket: @escaping GetRocketFunction = XCTUnimplemented("\(Self.self).getRocket"),
    getAllRockets: @escaping GetAllRocketsFunction = XCTUnimplemented("\(Self.self).getAllRockets")
  ) -> Self {
    .init(getRocket: getRocket, getAllRockets: getAllRockets)
  }
}
#endif
