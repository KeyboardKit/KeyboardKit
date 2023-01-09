//
//  HomeScreen.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import SwiftUIKit

/**
 This screen shows the status of the demo keyboard and links
 to another screen, where you can try out the demo keyboards.
 */
struct HomeScreen: View {
    
    @StateObject
    private var keyboardState = KeyboardEnabledState(
        bundleId: "com.keyboardkit.demo.keyboard")
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Type")) {
                    linkToEditScreen(.light)
                    linkToEditScreen(.dark)
                }
                Section(header: Text("Keyboard"), footer: footerText) {
                    KeyboardEnabledLabel(
                        isEnabled: keyboardState.isKeyboardEnabled,
                        enabledText: "Keyboard is enabled",
                        disabledText: "Keyboard is disabled")
                    KeyboardEnabledLabel(
                        isEnabled: keyboardState.isFullAccessEnabled,
                        enabledText: "Full Access is enabled",
                        disabledText: "Full Access is disabled")
                    KeyboardSettingsLink()
                }
            }
            .buttonStyle(.list)
            .listStyle(.insetGrouped)
            .navigationTitle("KeyboardKit Demo")
        }
        .navigationViewStyle(.stack)
        .environmentObject(keyboardState)
    }
}

extension HomeScreen {
    
    var footerText: some View {
        Text("You must enable the keyboard in System Settings, then select it with 🌐 when typing.")
    }

    func linkToEditScreen(_ appearance: ColorScheme) -> some View {
        NavigationLink(destination: EditScreen(appearance: appearance)) {
            Label(appearance.displayTitle, image: .type)
        }
    }
}

extension ColorScheme {

    var displayTitle: String {
        switch self {
        case .dark: return "Dark text field"
        default:  return "Regular text field"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
