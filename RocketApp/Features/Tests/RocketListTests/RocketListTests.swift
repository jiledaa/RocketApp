@testable import RocketList
import XCTest
import RocketsClient
import ComposableArchitecture
import Combine
import Networking

final class RocketListTests: XCTestCase {
  var store = TestStore(initialState: RocketListCore.State(), reducer: RocketListCore())

  func testFlow_rocketListCell_cellTapped_to_navigate() throws {
    var state = RocketListCore.State()
    state.rocketsData = .init(arrayLiteral: .init(rocketData: RocketDetail.mock))

    store = TestStore(initialState: state, reducer: RocketListCore())

    store.send(.rocketListCell(id: "apollo13", action: .cellTapped)) {
      $0.route = .rocketDetail(.init(rocketData: RocketDetail.mock))
    }

    store.send(.setNavigation(isActive: true))

    store.send(.setNavigation(isActive: false)) {
      $0.route = nil
    }
  }

  func testFlow_dataFetched_success() throws {
    store.dependencies.rocketsClient.getAllRockets = {
      Just([RocketDetail.mock])
        .setFailureType(to: NetworkError.self)
        .eraseToAnyPublisher()
    }

    store.send(.fetchData)

    store.receive(.dataFetched(.success([RocketDetail.mock]))) {
      $0.rocketsData = .init(arrayLiteral: .init(rocketData: RocketDetail.mock))
    }
  }

  func testFlow_dataFetched_failure() throws {
    store.dependencies.rocketsClient.getAllRockets = {
      Fail(error: NetworkError.noConnection)
        .eraseToAnyPublisher()
    }

    store.send(.fetchData)

    store.receive(.dataFetched(.failure(NetworkError.noConnection))) {
      $0.rocketsError = NetworkError.noConnection
    }
  }
}
