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
                localization: .init(
                    statusSectionTitle: "Keyboard status"
                ),
                topListContent: editorLinkSection,
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
            speechRecognizer: StandardSpeechRecognizer()
        ) {
            Dictation.Screen(
                dictationContext: dictationContext
            ) {
                EmptyView()
            } indicator: {
                Dictation.BarVisualizer(isAnimating: $0)
            } doneButton: { action in
                Button("Done", action: action)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

extension HomeScreen {

    func textFieldSection() -> some View {
        Section(header: Text("Text Field")) {
            TextEditor(text: $text)
                .frame(height: 100)
                .keyboardAppearance(appearance)
            Toggle(isOn: $isAppearanceDark) {
                Text("Dark appearance")
            }
        }
    }

    func editorLinkSection() -> some View {
        Section(header: Text("Editor")) {
            NavigationLink {
                TextEditor(text: $text)
                    .padding(.horizontal)
                    .navigationTitle("Editor")
            } label: {
                Label {
                    Text("Full screen editor")
                } icon: {
                    Image(systemName: "doc.text")
                }
            }
        }
    }
    
    var footerText: some View {
        Text("You must enable the keyboard in System Settings, then select it with 🌐 when typing.")
    }
}

#Preview {
    
    HomeScreen()
}
