//
//  ContentView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

struct ContentView: View {
    
    @State private var isKeyboardActive = false
    
    @StateObject private var keyboardState = KeyboardState()
    
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
        .onAppear(perform: updateState)
        .onReceive(activePublisher) { _ in updateState() }
    }
}

private extension ContentView {
    
    var activePublisher: NotificationCenter.Publisher {
        publisher(for: UIApplication.didBecomeActiveNotification)
    }
    
    var footerText: some View {
        Text("You must enable the keyboard under system settings, then select it in your keyboard, using the globe button.")
            .multilineTextAlignment(.center)
    }
    
    var stateColor: Color {
        isKeyboardActive ? .green : .orange
    }
    
    var stateIcon: Image {
        isKeyboardActive ? .checkmark : .alert
    }
    
    var stateText: String {
        isKeyboardActive ? "The keyboard is enabled" : "The keyboard is disabled"
    }
    
    func publisher(for notification: Notification.Name) -> NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: notification)
    }
    
    func openSettings() {
        guard let url = URL.keyboardSettings else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func updateState() {
        let bundleId = "com.keyboardkit.demo.keyboard"
        isKeyboardActive = keyboardState.isKeyboardEnabled(for: bundleId)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class KeyboardState: KeyboardStateInspector, ObservableObject {}
