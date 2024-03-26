import SwiftUI

@available(*, deprecated, renamed: "KeyboardLocale.ContextMenu")
public typealias LocaleContextMenu = KeyboardLocale.ContextMenu

@available(*, deprecated, renamed: "KeyboardLocale.Dictionary")
public typealias LocaleDictionary = KeyboardLocale.Dictionary

public extension View {

    @available(*, deprecated, renamed: "keyboardLocaleContextMenu(for:tapAction:)")
    func localeContextMenu(
        for context: KeyboardContext,
        tapAction: @escaping () -> Void
    ) -> some View {
        keyboardLocaleContextMenu(
            for: context,
            tapAction: tapAction
        )
    }

    @available(*, deprecated, renamed: "keyboardLocaleContextMenu(for:tapAction:menuItem:)")
    func localeContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        tapAction: @escaping () -> Void,
        menuItem: @escaping (Locale) -> ButtonView
    ) -> some View {
        keyboardLocaleContextMenu(
            for: context,
            tapAction: tapAction,
            menuItem: menuItem
        )
    }
}
