import ErrorReporting
import Foundation
import Networking

public struct RocketsClientError: ErrorReporting {
  public var stackID: UUID

  public let cause: Cause
  public var causeDescription: String { cause.description }

  public var underlyingError: ErrorReporting?

  public enum Cause: Error, CustomStringConvertible, Equatable {
    case networkError
    case modelConversionError

    public var description: String {
      switch self {
      case .networkError:
        return "networkError"
      case .modelConversionError:
        return "modelConversionError"
      }
    }
  }

  private init(stackID: UUID = UUID(), cause: Cause, underlyingError: ErrorReporting? = nil) {
    self.stackID = stackID
    self.cause = cause
    self.underlyingError = underlyingError
  }
}

// MARK: Equatable conformance
extension RocketsClientError: Equatable {
  public static func == (lhs: RocketsClientError, rhs: RocketsClientError) -> Bool {
    lhs.isEqual(to: rhs)
  }
}

// MARK: NetworkErrorCapable conformance
extension RocketsClientError: NetworkErrorCapable {
  public static var networkError: RocketsClientError {
    .init(cause: .networkError)
  }
}
// MARK: ModelConvertibleErrorCapable conformance
extension RocketsClientError: ModelConvertibleErrorCapable {
  public static var modelConvertibleError: RocketsClientError { .init(cause: .modelConversionError) }
}
