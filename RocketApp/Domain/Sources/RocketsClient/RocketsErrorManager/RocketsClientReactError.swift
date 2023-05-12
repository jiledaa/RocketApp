import ErrorReporting
import Foundation
import Networking

public struct RocketsClientReactError: CombineErrorReporting {
  public var stackID: UUID

  public let cause: Cause
  public var causeDescription: String { cause.description }

  public var underlyingError: CombineErrorReporting?

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

  private init(stackID: UUID = UUID(), cause: Cause, underlyingError: CombineErrorReporting? = nil) {
    self.stackID = stackID
    self.cause = cause
    self.underlyingError = underlyingError
  }
}

// MARK: - Equatable conformance

extension RocketsClientReactError: Equatable {
  public static func == (lhs: RocketsClientReactError, rhs: RocketsClientReactError) -> Bool {
    lhs.isEqual(to: rhs)
  }
}

// MARK: - Conformance instances

extension RocketsClientReactError: NetworkErrorCapable, ModelConvertibleErrorCapable, URLRequestBuilderErrorCapable {
  public static var networkError: RocketsClientReactError { .init(cause: .networkError) }
  public static var modelConvertibleError: RocketsClientReactError { .init(cause: .modelConversionError) }
  public static var urlRequestBuilderError: RocketsClientReactError { .init(cause: .networkError) }
}
