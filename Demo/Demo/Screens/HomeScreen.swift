//
//  HomeScreen.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

struct HomeScreen: View {
    
    @StateObject private var keyboardState = KeyboardEnabledState(bundleId: "com.keyboardkit.demo.keyboard")
    
    var body: some View {
        NavigationView {
            DemoList("KeyboardKit") {
                Section(header: Text("Type").padding(.top, 30)) {
                    NavigationLink(destination: EditScreen(appearance: .light)) {
                        DemoListItem(.type, "Type in a regular text field")
                    }
                    NavigationLink(destination: EditScreen(appearance: .dark)) {
                        DemoListItem(.type, "Type in a dark text field")
                    }
                }
                Section(header: Text("Setting")) {
                    DemoListItem(stateIcon, stateText).foregroundColor(stateColor)
                    DemoListButton(.settings, "System settings", .navigationArrow, action: openSettings)
                }
                Section(footer: footerText) {}
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension HomeScreen {
    
    var footerText: some View {
        Text("You must enable the keyboard under system settings, then select it in your keyboard, using the globe button.")
            .multilineTextAlignment(.center)
    }
    
    var stateColor: Color {
        isKeyboardEnabled ? .green : .orange
    }
    
    var stateIcon: Image {
        isKeyboardEnabled ? .checkmark : .alert
    }
    
    var stateText: String {
        isKeyboardEnabled ? "The keyboard is enabled" : "The keyboard is disabled"
    }
}

private extension HomeScreen {
    
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
