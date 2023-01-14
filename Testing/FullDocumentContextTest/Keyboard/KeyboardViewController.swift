//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-11.
//

import KeyboardKitPro
import SwiftUI

class KeyboardViewController: KeyboardInputViewController {

    /// This is used to show if the keyboard crashes
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

    var body: some View {
        VStack {
            HStack {
                textField
                    .padding()
                    .focused($isTextFieldFocused)
                Spacer()
                textFieldToggle
            }
            HStack {
                Button("Read", action: readText)
                Button("Read before", action: readTextBefore)
                Button("Read after", action: readTextAfter)
                Button("Resign", action: resign)
                Button("Type") {
                    actionHandler.handle(.tap, on: .character("B"))
                }
            }

            ScrollView(.vertical) {
                resultTextView
            }.frame(height: 250)
            Divider()
            Text(id.uuidString)
                .font(.footnote)
        }
        .buttonStyle(.borderedProminent)
        .background(Color.random())
    }
}

extension KeyboardView {

    var resultTextView: some View {
        Text(text)
            .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    var textField: some View {
        if isTextFieldVisible {
            KeyboardTextField(
                text: $text
            )
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
    }

    var textFieldToggle: some View {
        Toggle("", isOn: $isTextFieldVisible)
            .labelsHidden()
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
original context before:
\(result.originalDocumentContextBeforeInput ?? "-")
---
original context after:
\(result.originalDocumentContextAfterInput ?? "-")
---
original context:
\(result.originalDocumentContext)
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
