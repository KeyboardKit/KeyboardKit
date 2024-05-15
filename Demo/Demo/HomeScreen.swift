//
//  HomeScreen.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This is the main demo app screen.
///
/// This view uses a KeyboardKit Pro `KeyboardApp.HomeScreen`
/// to show keyboard-specific statuses with a few additional
/// views above and below the statuses.
struct HomeScreen: View {

    @State
    private var appearance = ColorScheme.light

    @State
    private var isAppearanceDark = false
    
    @State
    private var isNumberPad = false

    @AppStorage("com.keyboardkit.demo.text")
    private var text = ""

    @StateObject
    private var dictationContext = DictationContext(
        config: .app
    )

    @StateObject
    private var keyboardStatus = KeyboardStatusContext(
        bundleId: "com.keyboardkit.demo.*"
    )

    var body: some View {
        NavigationView {
            KeyboardApp.HomeScreen(
                appIcon: Image(.icon),
                keyboardBundleId: "com.keyboardkit.demo.*",
                topListContent: {},
                bottomListContent: textFieldSection
            )
            .navigationTitle("KeyboardKit")
            .onChange(of: isAppearanceDark) { newValue in
                appearance = isAppearanceDark ? .dark : .light
            }
        }
        .navigationViewStyle(.stack)
        .keyboardAppHomeScreenStyle(
            .init(appIconSize: 120)
        )
        .keyboardDictation(
            context: dictationContext,
            config: .app,
            speechRecognizer: StandardSpeechRecognizer(),
            overlay: dictationScreen
        )
        .keyboardStatusSectionStyle(
            .init(systemSettingsLink: .always)
        )
    }
}

extension HomeScreen {
    
    func dictationScreen() -> some View {
        Dictation.Screen(
            dictationContext: dictationContext
        ) {
            EmptyView()
        } visualizer: {
            Dictation.BarVisualizer(isAnimating: $0)
        } doneButton: { action in
            Button("Done", action: action)
                .buttonStyle(.borderedProminent)
        }
    }
    
    var footerText: some View {
        Text("You must enable the keyboard in System Settings, then select it with 🌐 when typing.")
    }
    
    func textFieldSection() -> some View {
        Section(header: Text("Text Field")) {
            TextField("Type here...", text: $text)
                .keyboardAppearance(appearance)
                .keyboardType(isNumberPad ? .numberPad : .alphabet)
            Toggle(isOn: $isAppearanceDark) {
                Text("Dark appearance")
            }
            // Toggle(isOn: $isNumberPad) {
            //     Text("Number Pad")
            // }
        }
    }
}

#Preview {
    
    HomeScreen()
}
