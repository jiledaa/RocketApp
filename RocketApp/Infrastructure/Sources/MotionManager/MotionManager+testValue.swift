#if DEBUG
import Foundation
import XCTestDynamicOverlay

extension MotionManager {
  public static var testValue = Self(getMotionData: unimplemented("\(Self.self).getMotionData"))
}
#endif
