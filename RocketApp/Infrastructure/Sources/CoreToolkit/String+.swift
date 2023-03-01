import Foundation

public extension String {
  var url: URL? {
    URL(string: self)
  }
}

public extension String {
  static func firstFlight<Error>(_ parameter: Error) -> Self {
    "First flight: \(parameter)"
  }

  static func firstFlight(_ parameter: Self) -> Self {
    "First flight: \(parameter)"
  }
}
