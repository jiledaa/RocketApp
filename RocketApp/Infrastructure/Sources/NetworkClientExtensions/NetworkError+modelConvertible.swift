import ErrorReporting
import Foundation
import Networking

extension NetworkError: ModelConvertibleErrorCapable {
  public static var modelConvertibleError: Networking.NetworkError { .noConnection }
}
