import Foundation
import SwiftUI

public extension String {
  var url: URL? {
    URL(string: self)
  }
}

public extension String {
  var nsLocalizedString: String {
    NSLocalizedString(self, bundle: .module, comment: "")
  }

  var localizedStringKey: LocalizedStringKey {
    LocalizedStringKey(nsLocalizedString)
  }

  func localizedStringKey(with arguments: [CVarArg]) -> LocalizedStringKey {
    let localizedString = String.localizedStringWithFormat(nsLocalizedString, arguments)
    return LocalizedStringKey(localizedString)
  }
}
