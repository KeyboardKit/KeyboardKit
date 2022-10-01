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
