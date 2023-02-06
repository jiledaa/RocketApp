import Combine
import Foundation
import Networking
import XCTestDynamicOverlay

extension RocketsClient {
  #if DEBUG
    func mock(
      getRocket: @escaping (String) -> AnyPublisher<RocketDetail, NetworkError> = XCTUnimplemented(),
      getRockets: @escaping () -> AnyPublisher<[RocketDetail], NetworkError> = XCTUnimplemented()
    ) -> RocketsClient {
      RocketsClient(getRocket: getRocket, getAllRockets: getRockets)
    }
  #endif
}
