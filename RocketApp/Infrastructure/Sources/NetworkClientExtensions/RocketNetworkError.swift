import Foundation
import Networking

public enum RocketNetworkError: Error, CustomStringConvertible, Equatable {
  case urlError(String)
  case invalidResponse
  case unauthorized
  case clientError(statusCode: Int)
  case serverError(statusCode: Int)
  case noConnection
  case jsonDecodingError(String)
  case urlRequestError
  case timeout

  init(networkError: NetworkError.Cause) {
    switch networkError {
    case .noConnection:
      self = .noConnection
    case let .urlError(error):
      self = .urlError("\(error)")
    case .invalidResponse:
      self = .invalidResponse
    case .unauthorized:
      self = .unauthorized
    case .clientError(statusCode: let statusCode):
      self = .clientError(statusCode: statusCode)
    case .serverError(statusCode: let statusCode):
      self = .serverError(statusCode: statusCode)
    case let .jsonDecodingError(error):
      self = .jsonDecodingError("\(error)")
    case .urlRequestError:
      self = .urlRequestError
    case .timeout:
      self = .timeout
    }
  }

  public var description: String {
    switch self {
    case let .urlError(urlError):
      return "urlError(urlError: \(urlError))"
    case .invalidResponse:
      return "invalidResponse"
    case .unauthorized:
      return "unauthorized"
    case let .clientError(statusCode):
      return "clientError(statusCode: \(statusCode))"
    case let .serverError(statusCode):
      return "serverError(statusCode: \(statusCode))"
    case .noConnection:
      return "noConnection"
    case let .jsonDecodingError(error):
      return "jsonDecodingError(error: \(error))"
    case .urlRequestError:
      return "urlRequestError"
    case .timeout:
      return "timeout"
    }
  }
}
