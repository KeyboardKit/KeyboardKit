import Foundation

#if os(iOS) || os(tvOS)
public extension KeyboardContext {

    /**
     The bundle ID of the currently active app.

     ``KeyboardInputViewController/activeAppBundleId`` fails
     to resolve bundle IDs in extensions in iOS 16, where it
     becomes `nil`. If we don't find a workaround for it, we
     have to remove this in the next major update.
     */
    @available(*, deprecated, message: "This no longer works in iOS 16 and will be removed in the next major version.")
    var activeAppBundleId: String? {
        KeyboardInputViewController.shared.activeAppBundleId
    }
}
#endif

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
