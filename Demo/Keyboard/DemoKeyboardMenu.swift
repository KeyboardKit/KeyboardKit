//
//  DemoKeyboardMenu.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-11-24.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

/// This menu is used when the main toolbar toggle is tapped
/// to present an alternate toolbar.
///
/// The file is added to the app as well, to enable previews.
struct DemoKeyboardMenu: View {
    
    let actionHandler: KeyboardActionHandler

    @Binding var isTextInputActive: Bool
    @Binding var isToolbarToggled: Bool
    @Binding var sheet: DemoSheet?

    let app = KeyboardApp.keyboardKitDemo
    
    // let docUrl = "https://keyboardkit.github.io/KeyboardKitPro/documentation/keyboardkitpro/"
    let webUrl = "https://keyboardkit.com"

    @EnvironmentObject var autocompleteContext: AutocompleteContext
    @EnvironmentObject var dictationContext: DictationContext
    @EnvironmentObject var feedbackContext: FeedbackContext
    @EnvironmentObject var keyboardContext: KeyboardContext
    @EnvironmentObject var themeContext: KeyboardThemeContext

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [
                .init(.adaptive(minimum: 115, maximum: 600))
            ]) {
                menuContent()
            }
            .padding(.bottom, 10)
            .background(Color.clearInteractable)            // Needed in keyboard extensions
        }
    }
}

extension DemoKeyboardMenu {

    @ViewBuilder
    func menuContent() -> some View {
        menuItem(
            title: "Menu.Settings",
            icon: .keyboardSettings,
            tint: .gray,
            action: { sheet = .keyboardSettings }
        )

        menuItem(
            title: "Menu.Languages",
            icon: .keyboardGlobe,
            tint: .blue,
            action: { sheet = .localeSettings }
        )

        menuItem(
            title: "Menu.Autocomplete",
            icon: .keyboardAutocomplete,
            tint: .orange,
            action: { sheet = .autocompleteSettings }
        )

        menuItem(
            title: "Menu.Feedback",
            icon: .keyboardFeedback,
            tint: .green,
            action: { sheet = .feedbackSettings }
        )

        menuItem(
            title: "Menu.Clipboard",
            icon: .keyboardClipboard,
            tint: .brown,
            action: { sheet = .clipboardSettings }
        )

        menuItem(
            title: "Menu.Fonts",
            icon: .keyboardFont,
            tint: .gray,
            action: { sheet = .fontSettings }
        )

        menuItem(
            title: "Menu.Themes",
            icon: .keyboardTheme,
            tint: .pink,
            action: { sheet = .themeSettings }
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
            tint: .indigo,
            action: { sheet = .fullDocumentReader }
        )

        menuItem(
            title: "Menu.HostApp",
            icon: .init(systemName: "lightbulb"),
            tint: .yellow,
            action: { sheet = .hostApplicationInfo }
        )

        menuItem(
            title: "Menu.OpenApp",
            icon: .init(systemName: "apps.iphone"),
            tint: .purple,
            action: { tryOpenUrl(app.deepLinks?.app) }
        )
        
        menuItem(
            title: "Menu.Experiments",
            icon: .init(systemName: "flask"),
            tint: .green,
            action: { sheet = .experimentSettings }
        )
        
        menuItem(
            title: "Menu.OpenWebsite",
            icon: .init(systemName: "safari"),
            tint: .blue,
            action: { tryOpenUrl(webUrl) }
        )
        
        menuItem(
            title: "Menu.CloseMenu",
            icon: .init(systemName: "xmark"),
            tint: .red,
            action: {}
        )
    }

    func menuItem(
        title: LocalizedStringKey,
        icon: Image,
        tint: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            withAnimation {
                isToolbarToggled.toggle()
                action()
            }
        } label: {
            VStack(alignment: .center, spacing: 10) {
                menuItemIcon(.keyboardSettings)             // Use same size
                    .opacity(0)
                    .overlay(menuItemIcon(icon))
                    .font(.title)
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .lineLimit(1)
            }
            .padding(5)
            .font(.footnote)
        }
        .symbolVariant(.fill)
        .modify { content in
            if #available(iOS 26, *) {
                content
                    .buttonStyle(.glassProminent)
            } else {
                content
                    .buttonStyle(.bordered)
                    .background(Color.primary.colorInvert())
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
            }
        }
        .tint(tint)
    }

    func menuItemIcon(
        _ icon: Image
    ) -> some View {
        icon.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25)
    }
}

private extension DemoKeyboardMenu {

    func tryOpenUrl(_ url: String?) {
        guard let url, let url = URL(string: url) else { return }
        actionHandler.handle(.url(url))
    }
}

public extension View {
    func modify(@ViewBuilder transform: (Self) -> some View) -> some View {
        transform(self)
    }
}

#Preview {
    DemoKeyboardMenu(
        actionHandler: .preview,
        isTextInputActive: .constant(false),
        isToolbarToggled: .constant(true),
        sheet: .constant(nil)
    )
    .padding(10)
    .background(Color.keyboardBackground)
}
