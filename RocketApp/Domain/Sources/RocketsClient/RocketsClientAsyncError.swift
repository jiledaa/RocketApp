import ErrorReporting
import Foundation
import Networking

public enum RocketsClientAsyncError: Error, Equatable, ErrorReportable {
  case networkError(NetworkError)
  case modelConversionError

  public var description: String {
    switch self {
    case let .networkError(error):
      return "network error \(error)"
    case .modelConversionError:
      return "model conversion error"
    }
  }

  public var viewDescription: String {
    switch self {
    case .networkError:
      return "Cannot load data :("
    case .modelConversionError:
      return "Cannot convert loaded data :("
    }
  }
}

public protocol ErrorReportable: CustomStringConvertible {
  var viewDescription: String { get }
}
