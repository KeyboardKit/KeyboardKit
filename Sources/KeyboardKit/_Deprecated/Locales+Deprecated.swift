#if os(iOS) || os(macOS) || os(watchOS)
import SwiftUI

public extension LocaleContextMenu {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead")
    init(
        context: KeyboardContext
    ) where MenuItem == Text {
        self.init(keyboardContext: context)
    }

    @available(*, deprecated, message: "Use the keyboardContext initializer instead")
    init(
        context: KeyboardContext,
        menuItem: @escaping (Locale) -> MenuItem
    ) {
        self.init(
            keyboardContext: context,
            menuItem: menuItem
        )
    }
}
#endif
