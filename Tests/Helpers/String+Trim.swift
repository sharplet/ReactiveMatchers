import Foundation

extension String {
  func trimmed() -> String {
    return stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
  }
}
