import Foundation
import Dependencies

extension DispatchQueue: DependencyKey {
  public static var liveValue = DispatchQueue.main.eraseToAnyScheduler()
}
