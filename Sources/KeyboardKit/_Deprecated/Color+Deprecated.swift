import SwiftUI

@available(*, deprecated, message: "This strategy is no longer used and will be removed in KeyboardKit 7.0")
public extension Color {

    /**
     This is a temporary typealias that is needed as long as
     iOS keyboard extensions are unable to differ between if
     dark mode is enabled or a dark appearance text field is
     being edited, as described in `Color+Button`.
     */
    typealias DarkAppearanceStrategy = (KeyboardContext) -> Bool

    /**
     This is a temporary property that is used to control if
     dark appearance should be applied or not. You can set a
     custom strategy if you want, but it shouldn't be needed.
     */
    static var darkAppearanceStrategy: DarkAppearanceStrategy = {
        // This is how we want things to work...
        // $0.colorScheme == .light && $0.keyboardAppearance == .dark
        // ...but according to the bug above, we go with the
        // dark appearance look for both dark appearance and
        // dark mode.
        $0.hasDarkColorScheme
    }
}
