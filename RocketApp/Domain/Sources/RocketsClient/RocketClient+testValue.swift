#if DEBUG
import Foundation
import XCTestDynamicOverlay

public extension RocketsClient {
   static let testValue = Self(
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
