#if os(iOS) || os(tvOS)
import Foundation

public extension KeyboardInputViewController {

    /**
     Get the bundle ID of the currently active app.
     */
    @available(*, deprecated, message: "This no longer works in iOS 16 and will be removed in the next major version.")
    var activeAppBundleId: String? {
        if Bundle.main.isExtension {
            return parent?.value(forKey: "_hostBundleID") as? String
        } else {
            return Bundle.main.bundleIdentifier
        }
    }
}
#endif
