@testable import RocketList
import Combine
import XCTest
import RocketsClient
import ComposableArchitecture
import NetworkClientExtensions

final class RocketListTests: XCTestCase {
  var store = TestStore(initialState: RocketListCore.State(), reducer: RocketListCore())

  func test_flow_rocketListCell_cellTapped_to_navigate() throws {
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

  func test_flow_dataFetched_success() throws {
    store.dependencies.rocketsClient.getAllRockets = {
      Just([RocketDetail.mock])
        .setFailureType(to: RocketNetworkError.self)
        .eraseToAnyPublisher()
    }

    store.dependencies.mainQueue = DispatchQueue.immediate.eraseToAnyScheduler()

    store.send(.fetchData)

    store.receive(.dataFetched(.success([RocketDetail.mock]))) {
      $0.rocketsData = .init(arrayLiteral: .init(rocketData: RocketDetail.mock))
    }
  }

  func test_flow_dataFetched_failure() throws {
    store.dependencies.rocketsClient.getAllRockets = {
      Fail(error: RocketNetworkError.noConnection)
        .eraseToAnyPublisher()
    }

    store.dependencies.mainQueue = DispatchQueue.immediate.eraseToAnyScheduler()

    store.send(.fetchData)

    store.receive(.dataFetched(.failure(RocketNetworkError.noConnection))) {
      $0.rocketsError = RocketNetworkError.noConnection
    }
  }
}
