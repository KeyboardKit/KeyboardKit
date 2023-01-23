//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-11.
//

import KeyboardKitPro
import SwiftUI

class KeyboardViewController: KeyboardInputViewController {

    /// This ID is used to indicate if the keyboard crashes
    var id = UUID()

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        try? setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            view: KeyboardView(
                id: id,
                actionHandler: keyboardActionHandler
            )
        )
    }
}

struct KeyboardView: View {

    var id: UUID

    var actionHandler: KeyboardActionHandler

    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    @FocusState
    private var isTextFieldFocused: Bool

    @State
    private var isTextFieldVisible = true

    @State
    private var text = "\(Date())"

    @State
    private var textBefore = ""

    @State
    private var textAfter = ""

    var body: some View {
        VStack {
            textFieldSection
            buttons
            resultSection
            Divider()
            Text(id.uuidString).font(.footnote)
        }
        .frame(height: 500)
        .buttonStyle(.borderedProminent)
        .background(Color.random().edgesIgnoringSafeArea(.all))
    }
}

extension KeyboardView {

    var buttons: some View {
        VStack {
            HStack {
                Button("Full", action: readText)
                Button("Before", action: readTextBefore)
                Button("After", action: readTextAfter)
            }
            HStack {
                Button("Resign", action: resign)
                Button("Return") {
                    actionHandler.handle(.release, on: .primary(.return))
                }
                Button(".") {
                    actionHandler.handle(.release, on: .character("."))
                }
                Button("Next") {
                    KeyboardInputViewController.shared.advanceToNextInputMode()
                }
            }
        }
    }

    var resultSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Result (\(text.count) chars...should be \(textBefore.count + textAfter.count)):").font(.footnote)
            TextEditor(text: $text).padding(.bottom)
            Text("Before (\(textBefore.count) chars):").font(.footnote)
            Text(textBefore.replacingOccurrences(of: "\n", with: "\\n")).lineLimit(3).padding(.bottom)
            Text("After (\(textAfter.count) chars):").font(.footnote)
            Text(textAfter.replacingOccurrences(of: "\n", with: "\\n")).lineLimit(3).padding(.bottom)
        }.padding()
    }

    @ViewBuilder
    var textField: some View {
        if isTextFieldVisible {
            KeyboardTextField(
                text: $text
            )
            .background(Color.white)
            .cornerRadius(10)
            .frame(height: 35)
        }
    }

    var textFieldSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("You can type here too:").font(.footnote)
            HStack {
                textField.focused($isTextFieldFocused)
                Spacer()
                Toggle("", isOn: $isTextFieldVisible)
                    .labelsHidden()
            }
        }.padding()
    }
}

extension KeyboardView {

    func readText() {
        Task {
            let result = try await keyboardContext
                .textDocumentProxy
                .fullDocumentContext()
            handleResult(result)
        }
    }

    func readTextBefore() {
        Task {
            let result = try await keyboardContext
                .textDocumentProxy
                .fullDocumentContextBeforeInput()
            handleResult(result)
        }
    }

    func readTextAfter() {
        Task {
            let result = try await keyboardContext
                .textDocumentProxy
                .fullDocumentContextAfterInput()
            handleResult(result)
        }
    }

    func resign() {
        isTextFieldFocused = false
    }

    @MainActor
    func handleResult(_ result: String) {
        text = result
    }

    @MainActor
    func handleResult(_ result: FullDocumentContextResult) {
        UIPasteboard.general.string = """
---
full context before:
\(result.fullDocumentContextBeforeInput)
---
full context after:
\(result.fullDocumentContextAfterInput)
---
full context: \(result.fullDocumentContext)
---
"""
        text = result.fullDocumentContext
        textBefore = result.fullDocumentContextBeforeInput
        textAfter = result.fullDocumentContextAfterInput
    }
}

extension Color {

    /**
     Generate a random color.

     - Parameters:
       - range: The random color range, by default `0...1`.
       - randomOpacity: Whether or not to randomize opacity as well, by default `false`.
     */
    static func random(
        in range: ClosedRange<Double> = 0...1,
        randomOpacity: Bool = false
    ) -> Color {
        Color(
            red: .random(in: range),
            green: .random(in: range),
            blue: .random(in: range),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
