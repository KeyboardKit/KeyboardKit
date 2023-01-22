#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {

    @available(*, deprecated, message: "This will be removed in KK7.")
    var trimmedDocumentContextAfterInput: String? {
        documentContextAfterInput?.trimmed()
    }

    @available(*, deprecated, message: "This will be removed in KK7.")
    var trimmedDocumentContextBeforeInput: String? {
        documentContextBeforeInput?.trimmed()
    }
}
#endif
