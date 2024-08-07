import SwiftUI

@available(*, deprecated, renamed: "KeyboardSettings.Link")
public typealias KeyboardSettingsLink = KeyboardSettings.Link

public extension KeyboardSettings {

    @available(*, deprecated, renamed: "setupStore")
    static func registerKeyboardSettingsStore(
        _ store: UserDefaults?,
        keyPrefix: String? = nil
    ) {
        setupStore(store, keyPrefix: keyPrefix)
    }
}
