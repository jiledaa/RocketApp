import Foundation
import Dependencies

enum DispatchQueueKey: DependencyKey {
  public static var liveValue: AnySchedulerOf<DispatchQueue> = DispatchQueue.liveValue
  #if DEBUG
  public static var testValue: AnySchedulerOf<DispatchQueue> = DispatchQueue.testValue
  #endif
}

public extension DependencyValues {
  var dispatchQueue: AnySchedulerOf<DispatchQueue> {
    get { self[DispatchQueueKey.self] }
    set { self[DispatchQueueKey.self] = newValue }
  }
}
