//
//  HomeScreen.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

struct HomeScreen: View {

    @State
    private var appearance = ColorScheme.light

    @State
    private var isAppearanceDark = false

    @State
    private var text = ""

    @StateObject
    private var keyboardState = KeyboardEnabledState(
        bundleId: "com.keyboardkit.demo.*")

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Text Field")) {
                    TextEditor(text: $text)
                        .frame(height: 100)
                        .keyboardAppearance(appearance)
                    Toggle(isOn: $isAppearanceDark) {
                        Text("Dark appearance")
                    }
                }
                Section(header: Text("Keyboard State"), footer: footerText) {
                    KeyboardEnabledLabel(
                        isEnabled: keyboardState.isKeyboardEnabled,
                        enabledText: "Demo keyboard is enabled",
                        disabledText: "Demo keyboard not enabled")
                    KeyboardEnabledLabel(
                        isEnabled: keyboardState.isKeyboardActive,
                        enabledText: "Demo keyboard is active",
                        disabledText: "Demo keyboard is not active")
                    KeyboardEnabledLabel(
                        isEnabled: keyboardState.isFullAccessEnabled,
                        enabledText: "Full Access is enabled",
                        disabledText: "Full Access is disabled")
                }
                Section(header: Text("Settings")) {
                    KeyboardSettingsLink()
                }
            }
            .buttonStyle(.plain)
            .navigationTitle("KeyboardKit")
            .onChange(of: isAppearanceDark) { newValue in
                appearance = isAppearanceDark ? .dark : .light
            }
        }
        .navigationViewStyle(.stack)
        .environment(\.layoutDirection, isRtl ? .rightToLeft : .leftToRight)
    }
}

extension HomeScreen {

    var footerText: some View {
        Text("You must enable the keyboard in System Settings, then select it with 🌐 when typing.")
    }

    var isRtl: Bool {
        keyboardState.activeKeyboardBundleIds.first?.hasSuffix("rtl") ?? false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
