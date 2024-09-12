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
/// to present keyboard-specific statuses and settings links,
/// with some additional views added below the standard list.
///
/// The ``dic``
///
/// See ``DemoApp`` for important information regarding some
/// limitations that this app has since it's not signed.
struct HomeScreen: View {

    @State
    private var text = ""

    @State
    private var textEmail = ""

    @State
    private var textURL = ""

    @State
    private var textWebSearch = ""

    @EnvironmentObject
    private var dictationContext: DictationContext

    var body: some View {
        NavigationView {
            KeyboardApp.HomeScreen(
                app: .demoApp,
                appIcon: Image(.icon),
                header: {},
                footer: textFieldSection
            )
            .navigationTitle("KeyboardKit")
        }
        .keyboardAppHomeScreenLocalization(
            .init(
                keyboardSectionFooter: "OBS! This demo app doesn't sync any settings between the app and the keyboard!"
            )
        )
        .keyboardAppHomeScreenStyle(
            .init(appIconSize: 150)
        )
        .keyboardAppHomeScreenVisibility(
            .init(keyboardSection: true)
        )
        .keyboardDictation(
            context: dictationContext,
            speechRecognizer: StandardSpeechRecognizer(),
            overlay: dictationScreen
        )
        .navigationViewStyle(.stack)
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
        Section("Text Fields") {
            TextField("Plain Text...", text: $text)
                .keyboardType(.default)
            TextField("Email...", text: $textEmail)
                .keyboardType(.emailAddress)
            TextField("URL...", text: $textURL)
                .keyboardType(.URL)
            TextField("Web Search...", text: $textWebSearch)
                .keyboardType(.webSearch)
        }
    }
}

#Preview {
    
    HomeScreen()
}
