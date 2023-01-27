import Foundation

public struct ApiFactory {
  private let requester: (URL) async throws -> (Data, URLResponse)

  public init(requester: @escaping (URL) async throws -> (Data, URLResponse)) {
    self.requester = requester
  }

  public func getData<T: Decodable>(from url: String) async throws -> T {
    guard let url = URL(string: url) else {
      throw APIError.badURL
    }

    let (data, _) = try await requester(url)
    return try JSONDecoder().decode(T.self, from: data)
  }
}
