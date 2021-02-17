//
//  KeyboardInputSetProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to preview keyboard views. Don't use
 it in other situations.
 */
public class PreviewKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init(context: ObservableKeyboardContext = .preview) {
        let inputProvider = StandardKeyboardInputSetProvider(context: context)
        provider = StandardKeyboardLayoutProvider(inputSetProvider: inputProvider)
    }
    
    private let provider: KeyboardLayoutProvider
    
    public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        provider.keyboardLayout(for: context)
    }
    
    public func register(inputSetProvider: KeyboardInputSetProvider) {
        provider.register(inputSetProvider: inputSetProvider)
    }
}
