import SwiftUI
import UIKit

extension Image {
  init?(nsData: NSData) {
    guard let uiImage = UIImage(data: Data(referencing: nsData)) else {
      return nil
    }

    self = Image(uiImage: uiImage)
  }
}
