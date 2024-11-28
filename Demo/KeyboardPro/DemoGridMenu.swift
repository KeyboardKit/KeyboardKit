//
//  DemoGridMenu.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-11-24.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKitPro

/// This menu is used when the toolbar plus toggle is tapped
/// to present an alternate toolbar.
///
/// The file is added to the app as well, to enable previews.
struct DemoGridMenu: View {

    @Binding var isTextInputActive: Bool
    @Binding var isToolbarToggled: Bool
    @Binding var sheet: DemoSheet?

    let actionHandler: KeyboardActionHandler

    let app = KeyboardApp.keyboardKitDemo
    
    let docUrl = "https://keyboardkit.github.io/KeyboardKitPro/documentation/keyboardkitpro/"
    let webUrl = "https://keyboardkit.com"

    @EnvironmentObject var autocompleteContext: AutocompleteContext
    @EnvironmentObject var dictationContext: DictationContext
    @EnvironmentObject var feedbackContext: KeyboardFeedbackContext
    @EnvironmentObject var keyboardContext: KeyboardContext
    @EnvironmentObject var themeContext: KeyboardThemeContext

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(
                columns: [.init(.adaptive(minimum: 180, maximum: 600))]
            ) {
                menuContent()
            }
        }
    }
}

extension DemoGridMenu {

    @ViewBuilder
    func menuContent() -> some View {
        menuItem(
            title: "Menu.Settings",
            icon: .keyboardSettings,
            tint: .primary,
            action: { sheet = .keyboardSettings }
        )

        menuItem(
            title: "Menu.Languages",
            icon: .keyboardGlobe,
            tint: .blue,
            action: { sheet = .localeSettings }
        )

        menuItem(
            title: "Menu.Themes",
            icon: .keyboardTheme,
            tint: .red,
            iconShadow: true,
            action: { sheet = .themeSettings }
        )

        menuItem(
            title: "Menu.Dictation",
            icon: .keyboardDictation,
            tint: .orange,
            action: { actionHandler.handle(.dictation) }
        )

        menuItem(
            title: "Menu.TextInput",
            icon: .init(systemName: "square.and.pencil"),
            tint: .teal,
            action: { isTextInputActive.toggle() }
        )

        menuItem(
            title: "Menu.ReadFullDocument",
            icon: .init(systemName: "doc.text.magnifyingglass"),
            tint: .brown,
            action: { sheet = .fullDocumentReader }
        )

        menuItem(
            title: "Menu.HostApp",
            icon: .init(systemName: "lightbulb"),
            tint: .indigo,
            iconTint: .yellow,
            action: { sheet = .hostApplicationInfo }
        )

        menuItem(
            title: "Menu.OpenApp",
            icon: .init(systemName: "apps.iphone"),
            tint: .gray,
            action: { tryOpenUrl(app.deepLinks?.app) }
        )

        menuItem(
            title: "Menu.OpenDocumentation",
            icon: .init(systemName: "book"),
            tint: .purple,
            action: { tryOpenUrl(docUrl) }
        )

        menuItem(
            title: "Menu.OpenWebsite",
            icon: .init(systemName: "safari"),
            tint: .blue,
            action: { tryOpenUrl(webUrl) }
        )
    }

    func menuItem(
        title: LocalizedStringKey,
        icon: Image,
        tint: Color = .teal,
        iconTint: Color? = nil,
        iconShadow: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            withAnimation {
                isToolbarToggled.toggle()
                action()
            }
        } label: {
            HStack(spacing: 10) {
                menuItemIcon(.init(systemName: "gearshape"))
                    .opacity(0)
                    .overlay(menuItemIcon(icon))
                    .font(.title)
                    .foregroundStyle(iconTint ?? tint)
                    .shadow(color: (iconShadow ? .black.opacity(0.3) : .clear), radius: 0, x: 0, y: 1)
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
            }
            .padding()
        }
        .symbolVariant(.fill)
        .symbolRenderingMode(.multicolor)
        .buttonStyle(.bordered)
        .tint(tint.gradient)
        .background(Color.primary.colorInvert())
        .clipShape(.rect(cornerRadius: 20))
        .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
    }

    func menuItemIcon(
        _ icon: Image
    ) -> some View {
        icon.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25)
    }
}

private extension DemoGridMenu {

    func tryOpenUrl(_ url: String?) {
        guard let url, let url = URL(string: url) else { return }
        actionHandler.handle(.url(url))
    }
}

#Preview {
    DemoGridMenu(
        isTextInputActive: .constant(false),
        isToolbarToggled: .constant(true),
        sheet: .constant(nil),
        actionHandler: .preview
    )
    .padding(10)
    .background(Color.red)
}
