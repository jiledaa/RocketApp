import ComposableArchitecture
@testable import RocketLaunch
import RocketsClient
import XCTest

final class RocketLaunchTests: XCTestCase {
  func testExample() throws {
    var store = TestStore(
      initialState: RocketLaunchCore.State(rocketData: .mock),
      reducer: RocketLaunchCore()
    )

    store.send(.onAppear) { _ in }

    store.receive(.updateMotionData(.success(.init(.init())))) {
      $0.calculatedHeight = 110
    }
  }
}
