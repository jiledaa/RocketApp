#if DEBUG
import Foundation
import XCTestDynamicOverlay

extension RocketsClient {
    static func mock(
      getRocket: @escaping GetRocketFunction = XCTUnimplemented("\(Self.self).getRocket"),
      getAllRockets: @escaping GetAllRocketsFunction = XCTUnimplemented("\(Self.self).getAllRockets")
    ) -> Self {
      .init(getRocket: getRocket, getAllRockets: getAllRockets)
    }
}
#endif
