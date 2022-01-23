import Foundation

#if os(iOS)
import UIKit

public extension EnglishInputSetProvider {
    
    @available(*, deprecated, message: "Use the new, device-agnostic initializer")
    convenience init(
        device: UIDevice = .current,
        numericCurrency: String = "$",
        symbolicCurrency: String = "£") {
        self.init(
            numericCurrency: numericCurrency,
            symbolicCurrency: symbolicCurrency)
    }
}

extension InternalSwedishInputSetProvider {
    
    @available(*, deprecated, message: "Use the new, device-agnostic initializer")
    convenience init(device: UIDevice = .current) {
        self.init()
    }
}
#endif
