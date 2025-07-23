//
//  DemoKeyboardView.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This demo-specific keyboard view sets up a `KeyboardView`
/// and customizes it with Pro features.
///
/// This keyboard view replaces the default top toolbar with
/// a toggle toolbar that has an alternate menu.
struct DemoKeyboardView: View {

    /// This is (for now) required by the ``DemoToolbar``.
    unowned var controller: KeyboardInputViewController
    
    @AppStorage("com.keyboardkit.demo.isToolbarToggled")
    var isToolbarToggled = false

    @Environment(\.keyboardToolbarStyle) var toolbarStyle

    @EnvironmentObject var themeContext: KeyboardThemeContext

    @State var activeSheet: DemoSheet?
    @State var isTextInputActive = false
    @State var theme: KeyboardTheme?

    var keyboardContext: KeyboardContext { state.keyboardContext }

    var body: some View {
        KeyboardView(
            state: controller.state,
            services: controller.services,
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
                        controller: controller,
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
            return params.standardActions(for: keyboardContext)
        }

        // 💡 Customize keyboard layout in any way you want.
        .keyboardLayout { params in
            let layout = params.standardLayout(for: keyboardContext)
            // guard keyboardContext.keyboardType == .alphabetic else { return layout }
            // var item = layout.createIdealItem(for: .character("!"))
            // item.size.width = .input
            // layout.itemRows.insert(item, after: .space)
            return layout
        }

        // 💡 Apply the currently selected theme, if any.
        .keyboardTheme(
            themeContext.currentTheme,
            context: keyboardContext
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

    var services: Keyboard.Services { controller.services }
    var state: Keyboard.State { controller.state }

    @ViewBuilder
    var menuGrid: some View {
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

    @ViewBuilder
    var sheetContent: some View {
        switch activeSheet {
        case .fullDocumentReader:
            FullDocumentContextSheet()
        case .hostApplicationInfo:
            HostAppInfoSheet(
                actionHandler: services.actionHandler
            )
        case .keyboardSettings:
            KeyboardApp.SettingsScreen(
                autocompleteContext: state.autocompleteContext,
                dictationContext: state.dictationContext,
                feedbackContext: state.feedbackContext,
                keyboardContext: state.keyboardContext
            )
        case .localeSettings:
            KeyboardApp.LocaleScreen(
                keyboardContext: state.keyboardContext
            )
        case .themeSettings:
            KeyboardApp.ThemeScreen(
                themeContext: state.themeContext
            )
        case .none: EmptyView()
        }
    }
}
