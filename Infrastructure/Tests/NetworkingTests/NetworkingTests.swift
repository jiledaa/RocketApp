@testable import Networking
import XCTest

final class NetworkingTests: XCTestCase {
     let apiFactory = ApiFactory(requester: { try await URLSession.shared.data(from: $0) })

     let testAPIFactory = ApiFactory { _ in
        try await Task.sleep(nanoseconds: NSEC_PER_SEC)
        return (Data(), URLResponse())
     }
}
