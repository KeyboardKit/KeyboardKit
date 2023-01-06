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

public extension KeyboardContext {

    #if os(iOS) || os(tvOS)
    @available(*, deprecated, message: "Use the initializer without keyboardType instead.")
    convenience init(
        controller: KeyboardInputViewController? = nil,
        locale: Locale = .current,
        keyboardType: KeyboardType
    ) {
        self.init(controller: controller)
        self.keyboardType = keyboardType
        self.locale = locale
        self.locales = [locale]
    }
    #else
    @available(*, deprecated, message: "Use the initializer without keyboardType instead.")
    convenience init(
        locale: Locale = .current,
        keyboardType: KeyboardType
    ) {
        self.init()
        self.keyboardType = keyboardType
        self.locale = locale
        self.locales = [locale]
    }
    #endif
}

#if os(iOS) || os(tvOS)
public extension KeyboardEnabledState {

    @available(*, deprecated, renamed: "isKeyboardActive")
    var isKeyboardCurrentlyActive: Bool {
        get { isKeyboardActive }
        set { isKeyboardActive = newValue }
    }
}

public extension KeyboardEnabledStateInspector {

    @available(*, deprecated, renamed: "isKeyboardActive")
    func isKeyboardCurrentlyActive(withBundleId bundleId: String) -> Bool {
        isKeyboardActive(withBundleId: bundleId)
    }
}
#endif

public extension KeyboardType {
    
    /**
     The keyboard type's standard button font size.
     */
    @available(*, deprecated, message: "This has been moved to StandardKeyboardAppearance")
    func standardButtonFontSize(for context: KeyboardContext) -> CGFloat {
        switch self {
        case .alphabetic: return 15
        case .numeric: return 16
        case .symbolic: return 14
        default: return 14
        }
    }
}
