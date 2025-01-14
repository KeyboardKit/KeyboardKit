//
//  Locale+ContextMenu.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Locale {
    
    /// This view modifier can apply locale context menus to
    /// any view.
    ///
    /// The easiest way to apply this modifier is to use the
    /// ``SwiftUICore/View/localeContextMenu(for:locales:tapAction:)``
    /// modifier to a view. This will apply the context menu
    /// to the view if either the explicitly provided locale
    /// list, or the global ``KeyboardContext/locales`` list
    /// contains at least two locales.
    ///
    /// This menu will sort and localizes the listed locales
    /// with the ``KeyboardContext/localePresentationLocale``.
    ///
    /// Note: The ``KeyboardView`` automatically applies the
    /// menu to ``KeyboardAction/nextLocale``, so you do not
    /// have to do it manually when using that view.
    struct ContextMenu<MenuItem: View>: ViewModifier {
        
        /// Create a menu that lists locales as `Text` views
        /// with the full localized name.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - locales: The explicit locales to list, if any.
        ///   - tapAction: The action to trigger when the view is tapped.
        public init(
            keyboardContext: KeyboardContext,
            locales: [Locale]? = nil,
            tapAction: @escaping () -> Void
        ) where MenuItem == Text {
            self.init(
                keyboardContext: keyboardContext,
                locales: locales,
                tapAction: tapAction
            ) {
                Text(Self.title(for: $0, in: keyboardContext.localePresentationLocale))
            }
        }
        
        /// Create a menu that lists locales as custom views.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - locales: The explicit locales to list, if any.
        ///   - tapAction: The action to trigger when the view is tapped.
        ///   - menuItem: A menu item view builder.
        public init(
            keyboardContext: KeyboardContext,
            locales: [Locale]? = nil,
            tapAction: @escaping () -> Void,
            @ViewBuilder menuItem: @escaping (Locale) -> MenuItem
        ) {
            self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
            self.locales = locales
            self.tapAction = tapAction
            self.menuItem = menuItem
        }
        
        @ObservedObject
        private var keyboardContext: KeyboardContext

        private var locales: [Locale]?
        private var tapAction: () -> Void
        private var menuItem: (Locale) -> MenuItem
        
        public func body(content: Content) -> some View {
            if menuLocales.count > 1 {
                #if os(iOS) || os(macOS) || os(visionOS)
                Menu(content: {
                    menu
                }, label: {
                    content
                }, primaryAction: tapAction)
                #else
                Button(action: tapAction) {
                    content
                }
                #endif
            } else {
                content
            }
        }
    }
}

private extension Locale.ContextMenu {

    var menu: some View {
        ForEach(menuLocales, id: \.identifier) { locale in
            Button(
                action: { keyboardContext.locale = locale },
                label: { menuItem(locale) }
            )
            if keyboardContext.locale == locale {
                Divider()
            }
        }
    }

    var menuLocales: [Locale] {
        let context = keyboardContext
        let presentationLocale = context.localePresentationLocale
        let locales = self.locales ?? context.selectableLocales
        return locales.sorted(in: presentationLocale, insertFirst: context.locale)
    }
    
    static func title(
        for locale: Locale,
        in presentationLocale: Locale
    ) -> String {
        locale.localizedName(in: presentationLocale) ?? ""
    }
}

public extension View {

    /// Apply a context menu that either lists a custom list
    /// of locales, or applicable locales from the `context`.
    ///
    /// - Parameters:
    ///   - context: The keyboard context to use.
    ///   - locales: The explicit locales to list, if any.
    ///   - tapAction: The action to trigger when the view is tapped.
    func localeContextMenu(
        for context: KeyboardContext,
        locales: [Locale]? = nil,
        tapAction: @escaping () -> Void
    ) -> some View {
        self.modifier(
            Locale.ContextMenu(
                keyboardContext: context,
                locales: locales,
                tapAction: tapAction
            )
        )
    }

    /// Apply a context menu that either lists a custom list
    /// of locales, or applicable locales from the `context`.
    ///
    /// - Parameters:
    ///   - context: The keyboard context to use.
    ///   - locales: The explicit locales to list, if any.
    ///   - tapAction: The action to trigger when the view is tapped.
    ///   - menuItem: A menu item view builder.
    func localeContextMenu<ButtonView: View>(
        for context: KeyboardContext,
        locales: [Locale]? = nil,
        tapAction: @escaping () -> Void,
        menuItem: @escaping (Locale) -> ButtonView
    ) -> some View {
        self.modifier(
            Locale.ContextMenu(
                keyboardContext: context,
                locales: locales,
                tapAction: tapAction,
                menuItem: menuItem
            )
        )
    }
}

#Preview {

    struct Preview: View {

        @StateObject
        var context: KeyboardContext = {
            let context = KeyboardContext()
            context.locales = .keyboardKitSupported
            context.localePresentationLocale = .english
            return context
        }()

        var localeName: String {
            context.locale.localizedName(in: context.localePresentationLocale) ?? "-"
        }

        var body: some View {
            VStack {
                Text("🌐 \(localeName)")
                    .localeContextMenu(
                    for: context,
                    // locales: [.swedish],
                    tapAction: { }
                )
                Button("Print locale") {
                    print(context.locale)
                }
            }
            .id(context.locale.identifier)
        }
    }

    return Preview()
}
