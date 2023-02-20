import Foundation
import Dependencies

extension DispatchQueue {
  public static var testValue = DispatchQueue.test.eraseToAnyScheduler()
}
