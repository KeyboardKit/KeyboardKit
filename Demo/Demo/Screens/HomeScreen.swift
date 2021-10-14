//
//  HomeScreen.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

import Foundation

class Test: UIInputViewController {}

struct HomeScreen: View {
    
    @StateObject private var keyboardState = KeyboardEnabledState(bundleId: "com.keyboardkit.demo.keyboard")
    
    var body: some View {
        NavigationView {
            DemoList("KeyboardKit") {
                Section(header: Text("Type").padding(.top, 30)) {
                    NavigationLink(destination: EditScreen(appearance: .default)) {
                        DemoListItem(.type, "Type in a regular text field")
                    }
                    NavigationLink(destination: EditScreen(appearance: .dark)) {
                        DemoListItem(.type, "Type in a dark text field")
                    }
                }
                Section(header: Text("Setting"), footer: footerText) {
                    EnabledListItem(
                        isEnabled: isKeyboardEnabled,
                        enabledText: "Keyboard is enabled",
                        disabledText: "Keyboard is disabled")
                    EnabledListItem(
                        isEnabled: isFullAccessEnabled,
                        enabledText: "Full Access is enabled",
                        disabledText: "Full Access is disabled")
                    DemoListButton(
                        .settings,
                        "System settings",
                        .navigationArrow, action: openSettings)
                }
            }
        }
        .environmentObject(keyboardState)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension HomeScreen {
    
    var footerText: some View {
        Text("You must enable the keyboard under system settings, then select it in your keyboard, using the globe button.")
    }
}

private extension HomeScreen {
    
    var isFullAccessEnabled: Bool {
        keyboardState.isFullAccessEnabled
    }
    
    var isKeyboardEnabled: Bool {
        keyboardState.isKeyboardEnabled
    }
    
    func openSettings() {
        guard let url = URL.keyboardSettings else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
