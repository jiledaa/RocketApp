import Foundation

public enum Loadable<Data, Error> {
  case notRequested
  case loading
  case success(Data)
  case error(Error)

  var isLoading: Bool {
    if case .loading = self {
      return true
    }

    return self.isLoading
  }
}
