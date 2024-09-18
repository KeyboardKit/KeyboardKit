//
//  DemoToolbar.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-11-27.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
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

    @Binding
    var theme: KeyboardTheme?

    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var feedbackContext: FeedbackContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    @FocusState
    private var isTextFieldFocused

    @State
    private var fullDocumentContext = ""
    
    @State
    private var isThemePickerPresented = false
    
    @State
    private var isFullDocumentContextActive = false
    
    @State
    private var text = ""

    var body: some View {
        try? Keyboard.ToggleToolbar(
            toolbar: autocompleteToolbar,
            toggledToolbar: menuToolbar
        )
        .tint(.primary)
    }
}

private extension DemoToolbar {

    var autocompleteToolbar: some View {
        HStack {
            toolbar.frame(maxWidth: .infinity)
            localeSwitcher
        }
    }

    var menuToolbar: some View {
        ScrollView(.horizontal) {
            HStack {
                Group {
                    textFieldIfFullAccess
                    Divider()
                    toggle($autocompleteContext.isAutocorrectEnabled, "textformat.abc.dottedunderline")
                    Divider()
                    toggle($feedbackContext.isAudioFeedbackEnabled, "speaker.wave.2.fill")
                    toggle($feedbackContext.isHapticFeedbackEnabled, "hand.tap.fill")
                    Divider()
                    button(toggleThemePicker, "paintpalette")
                    button(readDocument, "doc.text.magnifyingglass")
                    button(startDictation, "mic")
                    button(openSettings, "gearshape")
                }
                .frame(maxHeight: .infinity)
            }
            .padding([.trailing, .vertical], 10)
            .background(Color.clearInteractable)
        }
        .font(.headline)
        .buttonStyle(.bordered)
        .toggleStyle(.button)
        .sheet(isPresented: $isFullDocumentContextActive, content: fullDocumentContextSheet)
        .sheet(isPresented: $isThemePickerPresented, content: themePickerSheet)
    }
}

private extension DemoToolbar {

    func button(
        _ action: @escaping () -> Void,
        _ imageName: String
    ) -> some View {
        Button(action: action) {
            image(imageName)
        }
    }

    func toggle(
        _ isOn: Binding<Bool>,
        _ imageName: String
    ) -> some View {
        Toggle(isOn: isOn) {
            image(imageName)
        }
    }

    func image(_ name: String) -> some View {
        Color.clear
            .overlay(Image(systemName: name))
            .frame(maxHeight: .infinity)
    }

    var localeSwitcher: some View {
        Image.keyboardGlobe
            .scaleEffect(1.2)
            .padding()
            .background(Color.clearInteractable)
            .keyboardLocaleContextMenu(for: keyboardContext) {
                controller.services.actionHandler.handle(.nextLocale)
            }
    }

    @ViewBuilder
    var textFieldIfFullAccess: some View {
        if keyboardContext.hasFullAccess {
            KeyboardTextField(text: $text, controller: controller) {
                $0.placeholder = "Type here..."
            }
            .frame(width: 150)
            .focused($isTextFieldFocused) {
                Image(systemName: "xmark.circle.fill")
            }
            .buttonStyle(.plain)
        }
    }
    
    func fullDocumentContextSheet() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(fullDocumentContext)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .demoSheet("Full Document Reader")
    }
    
    func themePickerSheet() -> some View {
        KeyboardTheme.Shelf(
            themes: KeyboardTheme.allPredefined
        ) { theme in
            self.theme = theme
        } title: { collection in
            Text(collection.name)
                .font(.callout.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
        } item: { theme in
            KeyboardTheme.ShelfItem(theme: theme)
                .shadow(radius: 1, x: 0, y: 1)
                .padding(.vertical, 3)
        }
        .demoSheet("Theme Picker")
    }
}

private extension DemoToolbar {
    
    func openSettings() {
        controller.openUrl(.systemSettings)
    }
    
    func readDocument() {
        isFullDocumentContextActive = true
        fullDocumentContext = "Reading..."
        Task {
            let result = try await keyboardContext.textDocumentProxy.fullDocumentContext()
            await MainActor.run { self.fullDocumentContext = result.fullDocumentContext }
        }
    }
    
    func selectTheme(_ theme: KeyboardTheme) {
        self.theme = theme
        isThemePickerPresented = false
    }
    
    func startDictation() {
        controller.performDictation()
    }

    func toggleThemePicker() {
        isThemePickerPresented.toggle()
    }
}

private extension View {
    
    func demoSheet(_ title: String) -> some View {
        NavigationView {
            ScrollView {
                self
            }
            .navigationTitle(title)
        }
    }
}

extension String: @retroactive Identifiable {
    
    public var id: String { self }
}
