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
        return "network error"
      case .modelConversionError:
        return "model conversion error"
      }
    }
  }

  private init(stackID: UUID = UUID(), cause: Cause, underlyingError: ErrorReporting? = nil) {
    self.stackID = stackID
    self.cause = cause
    self.underlyingError = underlyingError
  }
}

// MARK: - Equatable conformance

extension RocketsClientError: Equatable {
  public static func == (lhs: RocketsClientError, rhs: RocketsClientError) -> Bool {
    lhs.isEqual(to: rhs)
  }
}

// MARK: - Conformance instances

extension RocketsClientError: NetworkErrorCapable, ModelConvertibleErrorCapable, URLRequestBuilderErrorCapable {
  public static var networkError: RocketsClientError { .init(cause: .networkError) }
  public static var modelConvertibleError: RocketsClientError { .init(cause: .modelConversionError) }
  public static var urlRequestBuilderError: RocketsClientError { .init(cause: .networkError) }
}
