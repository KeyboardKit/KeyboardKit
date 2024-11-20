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
/// This view uses a KeyboardKit Pro `HomeScreen` to present
/// keyboard status and settings links with some adjustments.
///
/// See ``DemoApp`` for important, demo-specific information
/// on why the in-app keyboard settings aren't synced to the
/// keyboards by default, and how you can enable this.
struct HomeScreen: View {

    @State var text = ""
    @State var textEmail = ""
    @State var textURL = ""
    @State var textWebSearch = ""

    @Environment(\.openURL) var openURL

    @EnvironmentObject var dictationContext: DictationContext
    @EnvironmentObject var keyboardContext: KeyboardContext
    @EnvironmentObject var themeContext: KeyboardThemeContext

    var body: some View {
        NavigationView {
            KeyboardApp.HomeScreen(
                app: .keyboardKitDemo,
                appIcon: Image(.icon),
                header: {},
                footer: {
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
            )
            .navigationTitle("KeyboardKit")
        }
        .keyboardAppHomeScreenLocalization(.init(
            keyboardSectionFooter: "OBS! This demo isn't code signed and therefore can't sync settings to its keyboard extensions!"
        ))
        .keyboardAppHomeScreenStyle(.init(
            appIconSize: 150
        ))
        .keyboardAppHomeScreenVisibility(.init(
            keyboardSection: true,
            keyboardSectionThemeSettings: true
        ))
        .keyboardDictation(
            dictationContext: dictationContext,
            keyboardContext: keyboardContext,
            openUrl: openURL,
            speechRecognizer: .standard,
            overlay: dictationScreen
        )
        .navigationViewStyle(.stack)
    }
}

extension HomeScreen {
    
    func dictationScreen() -> some View {
        Dictation.Screen(
            dictationContext: dictationContext,
            titleView: { EmptyView() },
            visualizer: { Dictation.BarVisualizer(isAnimating: $0) },
            doneButton: { action in
                Button("Done", action: action)
                    .buttonStyle(.borderedProminent)
            }
        )
    }
}

#Preview {
    
    HomeScreen()
}
