//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-11.
//

import KeyboardKitPro
import SwiftUI

class TestState {

    static let shared = TestState()

    var result = ""
}

class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        try? setupPro(
            withLicenseKey: "299B33C6-061C-4285-8189-90525BCAF098",
            view: KeyboardView()
        )
    }
}

struct KeyboardView: View {

    @EnvironmentObject
    private var context: KeyboardContext

    @State
    private var text = "\(Date())"

    var body: some View {
        VStack {
            Button("Read full document text") {
                Task {
                    let result = try await context
                        .textDocumentProxy
                        .fullDocumentContext()
                        .fullDocumentContext
                    updateText(result)
                }
            }
            Text(text)
                .frame(height: 250)
        }.background(Color.random() )
            .overlay(Text(context.keyboardType.id))
    }

    @MainActor
    func updateText(_ newText: String) {
        text = newText
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
