//
//  DemoKeyboardView.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This demo-specific keyboard view sets up a `KeyboardView`
/// and customizes it with Pro features.
///
/// This keyboard view replaces the default top toolbar with
/// a toggle toolbar that has an alternate menu.
struct DemoKeyboardView: View {

    var services: Keyboard.Services
    var state: Keyboard.State

    @AppStorage("com.keyboardkit.demo.isToolbarToggled")
    var isToolbarToggled = false

    @EnvironmentObject var themeContext: KeyboardThemeContext

    @State var activeSheet: DemoSheet?
    @State var isTextInputActive = false
    @State var theme: KeyboardTheme?

    var keyboardContext: KeyboardContext { state.keyboardContext }

    var body: some View {
        KeyboardView(
            layout: demoLayout,
            services: services,
            buttonContent: { $0.view },                     // $0.view uses the default view.
            buttonView: {
                $0.view.opacity(isToolbarToggled ? 0 : 1)   // Hide keys when the toolbar is toggled
            },
            collapsedView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { params in                            // All view builders have parameters
                if isTextInputActive {
                    DemoTextInputToolbar(
                        isTextInputActive: $isTextInputActive
                    )
                } else {
                    DemoToolbar(
                        services: services,
                        toolbar: params.view,               // Use the original toolbar
                        isTextInputActive: $isTextInputActive,
                        isToolbarToggled: $isToolbarToggled
                    )
                }
            }
        )
        .overlay(menuGrid)
        .animation(.bouncy, value: isToolbarToggled)

        // 💡 Customize callout actions in any way you want.
        .keyboardCalloutActions { params in                 // Apply custom actions to "K" key
            if case .character(let char) = params.action, char == "K" {
                return .init(characters: String("keyboardkit".reversed()))
            }
            return params.standardActions()
        }

        // 💡 Apply the currently selected theme, if any.
        .keyboardTheme(
            themeContext.currentTheme
        )

        // 💡 This sheet can be used to show the main menu.
        .sheet(item: $activeSheet) { sheet in
            NavigationStack {
                sheetContent
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Button.Done") {
                                activeSheet = nil
                            }
                        }
                    }
            }
        }
    }
}

private extension DemoKeyboardView {

    // 💡 Setup a custom keyboard layout
    var demoLayout: KeyboardLayout {
        NSLog("Creating a custom layout")
        var layout = KeyboardLayout.standard(for: keyboardContext)
        guard keyboardContext.keyboardType == .alphabetic else { return layout }
        var item = layout.createIdealItem(for: .rocket)
        item.size.width = .input
        layout.itemRows.insert(item, after: .space)
        return layout
    }

    // 💡 This menu view is shown when the menu is activated.
    @ViewBuilder var menuGrid: some View {
        if isToolbarToggled {
            DemoKeyboardMenu(
                actionHandler: services.actionHandler,
                isTextInputActive: $isTextInputActive,
                isToolbarToggled: $isToolbarToggled,
                sheet: $activeSheet
            )
            .padding(.top, 55)  // Give room for the toolbar
            .padding(.horizontal, 10)
            .transition(.move(edge: .bottom))
        }
    }

    // 💡 This view builder creates misc sheet content views.
    @ViewBuilder var sheetContent: some View {
        switch activeSheet {
        case .fullDocumentReader:
            FullDocumentContextSheet()
        case .hostApplicationInfo:
            HostAppInfoSheet(actionHandler: services.actionHandler)
        case .keyboardSettings:
            Keyboard.SettingsScreen()
        case .localeSettings:
            Keyboard.LocaleSettingsScreen()
        case .themeSettings:
            KeyboardTheme.SettingsScreen()
        case .none: EmptyView()
        }
    }
}
