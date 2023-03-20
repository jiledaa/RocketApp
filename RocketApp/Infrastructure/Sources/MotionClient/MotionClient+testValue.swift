#if DEBUG
import Foundation
import XCTestDynamicOverlay

extension MotionClient {
  public static var testValue = Self(motionClient: unimplemented("\(Self.self).getMotionData"))
}
#endif
