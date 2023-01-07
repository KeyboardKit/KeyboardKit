//
//  HomeScreen.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI
import SwiftUIKit

/**
 This screen shows the status of the demo keyboard and links
 to another screen, where you can try out the demo keyboards.
 */
struct HomeScreen: View, UrlOpener {
    
    @StateObject
    private var keyboardState = KeyboardEnabledState(
        bundleId: "com.keyboardkit.demo.keyboard")
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Type")) {
                    NavigationLink(destination: EditScreen(appearance: .default)) {
                        Label("Type in a regular text field", image: .type)
                    }
                    NavigationLink(destination: EditScreen(appearance: .dark)) {
                        Label("Type in a dark text field", image: .type)
                    }
                }
                Section(header: Text("Keyboard"), footer: footerText) {
                    EnabledListItem(
                        isEnabled: keyboardState.isKeyboardEnabled,
                        enabledText: "Keyboard is enabled",
                        disabledText: "Keyboard is disabled")
                    EnabledListItem(
                        isEnabled: keyboardState.isFullAccessEnabled,
                        enabledText: "Full Access is enabled",
                        disabledText: "Full Access is disabled")
                    Button(action: { tryOpen(.keyboardSettings) }) {
                        Label("System settings", image: .settings)
                    }
                }
            }
            .buttonStyle(.list)
            .listStyle(.insetGrouped)
            .navigationTitle("KeyboardKit Pro Demo")
        }
        .navigationViewStyle(.stack)
        .environmentObject(keyboardState)
    }
}

private extension HomeScreen {
    
    var footerText: some View {
        Text("You must enable the keyboard in System Settings, then select it with 🌐 when typing.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
