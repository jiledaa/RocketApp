#if DEBUG
import Foundation
import Dependencies
import XCTestDynamicOverlay

extension DispatchQueue {
  public static var testValue = DispatchQueue.immediate.eraseToAnyScheduler()
}
#endif
