//
//  InputViewEditScreen.swift
//  Demo
//
//  Created by Nick Brook on 01/11/2022.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

struct CustomKeyboardView: View {
    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    
    var body: some View {
        VStack(spacing: 0) {
            if keyboardContext.keyboardType != .emojis {
                autocompleteToolbar
            }
            SystemKeyboard()
        }
    }
    var autocompleteToolbar: some View {
        AutocompleteToolbar(
            suggestions: autocompleteContext.suggestions,
            locale: keyboardContext.locale
        ).frame(height: 50)
    }
}

class CustomKeyboardViewController: KeyboardInputViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup(with: CustomKeyboardView())
    }
}

/**
 This screen has a multi-line text field that can be used to
 try KeyboardKit with various keyboard appearance presets.
 */
struct InputViewEditScreen: View {
    
    let appearance: UIKeyboardAppearance
    
    @State
    private var text = ""
    
    var body: some View {
        List {
            Section {
                MultilineTextField(text: $text, appearance: appearance, configuration: {
                    $0.inputView = CustomKeyboardViewController().view
                    $0.reloadInputViews()
                })
                    .frame(height: 200)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(title)
    }
}

private extension InputViewEditScreen {
    var title: String {
        appearance == .dark ? "Dark text field" : "Regular text field"
    }
}

struct InputViewEditScreen_Previews: PreviewProvider {

    static var previews: some View {
        InputViewEditScreen(appearance: .default)
    }
}
