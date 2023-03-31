import ComposableArchitecture
@testable import RocketListCell
import RocketsClient
import XCTest

final class RocketListCellTests: XCTestCase {
  func test_cell_tapped() throws {
    let store = TestStore(initialState: RocketListCellCore.State(rocketData: .mock), reducer: RocketListCellCore())
    store.send(.cellTapped)
  }
}
