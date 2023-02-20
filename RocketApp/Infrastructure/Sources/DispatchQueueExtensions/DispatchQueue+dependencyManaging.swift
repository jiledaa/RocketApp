import Dependencies
import Foundation

enum DispatchQueueKey: DependencyKey {
  public static var liveValue: AnySchedulerOf<DispatchQueue> = DispatchQueue.liveValue
  public static var testValue: AnySchedulerOf<DispatchQueue> = DispatchQueue.testValue
}

public extension DependencyValues {
  var dispatchQueue: AnySchedulerOf<DispatchQueue> {
    get { self[DispatchQueueKey.self] }
    set { self[DispatchQueueKey.self] = newValue }
  }
}
