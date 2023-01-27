import Foundation

public enum APIError: Error {
  case badURL
  case downloadError
  case decodingError
}
