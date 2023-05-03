import ErrorReporting
import Foundation
import Networking

public struct RocketsClientAsyncError {
  public enum Cause: Error, CustomStringConvertible, Equatable {
    case networkError
    case modelConversionError

    public var description: String {
      switch self {
      case .networkError:
        return "network error"
      case .modelConversionError:
        return "model conversion error"
      }
    }
  }
}

// MARK: - Equatable conformance

//extension RocketsClientAsyncError: Equatable {
//  public static func == (lhs: RocketsClientError, rhs: RocketsClientError) -> Bool {
//    lhs.isEqual(to: rhs)
//  }
//}
