import ErrorReporting
import Foundation
import Networking

public struct RocketsClientError: ErrorReporting {
  public var stackID: UUID

  public let cause: Cause
  public var causeDescription: String { cause.description }

  public var underlyingError: ErrorReporting?

  public enum Cause: Error, CustomStringConvertible, Equatable {
    case networkError(NetworkError)
    case modelConversionError

    public var description: String {
      switch self {
      case let .networkError(error):
        return "\(error.causeDescription)"
      case .modelConversionError:
        return "modelConversionError"
      }
    }
  }

  public init(stackID: UUID = UUID(), cause: Cause, underlyingError: ErrorReporting? = nil) {
    self.stackID = stackID
    self.cause = cause
    self.underlyingError = underlyingError
  }
}

extension RocketsClientError: ModelConvertibleErrorCapable {
  public static var modelConvertibleError: RocketsClientError { .init(cause: .modelConversionError) }
}

extension RocketsClientError: Equatable {
  public static func == (lhs: RocketsClientError, rhs: RocketsClientError) -> Bool {
    lhs.isEqual(to: rhs)
  }
}
