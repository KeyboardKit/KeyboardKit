//
//  DemoToolbar.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-11-27.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This demo-specific toolbar is used as the `ToggleToolbar`
/// toggled view in ``DemoKeyboardView``.
///
/// This toolbar has a textfield to let you type and buttons
/// to toggle state, trigger actions, etc.
struct DemoToolbar<Toolbar: View>: View {

    /// This is (for now) required by the `KeyboardTextField`.
    unowned var controller: KeyboardInputViewController

    var toolbar: Toolbar

    @Binding var isTextInputActive: Bool
    @Binding var isToolbarToggled: Bool

    @EnvironmentObject var autocompleteContext: AutocompleteContext
    @EnvironmentObject var feedbackContext: KeyboardFeedbackContext
    @EnvironmentObject var keyboardContext: KeyboardContext

    @FocusState var isTextFieldFocused

    @State var fullDocumentContext = ""
    @State var isThemePickerPresented = false
    @State var isFullDocumentContextActive = false
    @State var text = ""

    var body: some View {
        try? Keyboard.ToggleToolbar(
            isToggled: $isToolbarToggled,
            toolbar: autocompleteToolbar,                   // Add a locale switcher to the toolbar
            toggledToolbar: toggledToolbar
        )
        .tint(.primary)
        .font(.title3)
        .buttonStyle(.plainKeyboard)
        .padding(.trailing)
    }
}

private extension DemoToolbar {

    var autocompleteToolbar: some View {
        HStack {
            toolbar.frame(maxWidth: .infinity)
            localeSwitcher
        }
    }

    var toggledToolbar: some View {
        HStack {
            Spacer()
            Button {
                keyboardContext.isKeyboardCollapsed.toggle()
            } label: {
                Image.keyboardDismiss
            }
        }
    }
}

private extension DemoToolbar {

    var localeSwitcher: some View {
        Image.keyboardGlobe
            .background(Color.clearInteractable)
            .localeContextMenu(for: keyboardContext) {
                controller.services.actionHandler.handle(.nextLocale)
            }
    }
}
