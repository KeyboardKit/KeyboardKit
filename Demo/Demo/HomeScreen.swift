//
//  HomeScreen.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
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

    let app = KeyboardApp.keyboardKitDemo

    @State var text = ""
    @State var textEmail = ""
    @State var textMultiline = ""
    @State var textNumberPad = ""
    @State var textURL = ""
    @State var textWebSearch = ""

    @Environment(\.openURL) var openURL

    @EnvironmentObject var dictationContext: DictationContext
    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: some View {
        NavigationView {
            KeyboardApp.HomeScreen(
                app: app,
                appIcon: Image(.icon),
                header: {
                    Text(
"""
OBS! This demo isn't code signed and therefore can't sync data with its keyboard. This means that dictation will not work.
"""
                    )
                    .listRowBackground(Color.yellow)
                    .multilineTextAlignment(.center)
                },
                footer: {
                    Section("Section.TextFields") {
                        TextField("TextField.Plain", text: $text)
                            .keyboardType(.default)
                        TextField("TextField.Email", text: $textEmail)
                            .keyboardType(.emailAddress)
                        TextField("TextField.NumberPad", text: $textNumberPad)
                            .keyboardType(.numberPad)
                        TextField("TextField.URL", text: $textURL)
                            .keyboardType(.URL)
                        TextField("TextField.WebSearch", text: $textWebSearch)
                            .keyboardType(.webSearch)
                        TextField("TextField.Multiline", text: $textMultiline, axis: .vertical)
                            .lineLimit(4, reservesSpace: true)
                            .keyboardType(.default)
                    }
                }
            )
            .navigationTitle(app.name)
        }
        .keyboardAppHomeScreenStyle(.init(
            appIconSize: 120,
            appIconCornerRadius: 27
        ))
        .keyboardAppHomeScreenVisibility(.init(
            settingsSectionFonts: true,
            settingsSectionThemes: true,
            settingsSectionExperiments: true,
        ))
        .keyboardDictation(
            speechRecognizer: .standard
        )
        .navigationViewStyle(.stack)
    }
}

extension HomeScreen {
    
    func dictationScreen() -> some View {
        Dictation.Screen(
            titleView: { EmptyView() },
            visualizer: { Dictation.BarVisualizer(isAnimating: $0) },
            doneButton: { action in
                Button("Button.Done", action: action)
                    .buttonStyle(.borderedProminent)
            }
        )
    }
}

#Preview {
    
    HomeScreen()
}
