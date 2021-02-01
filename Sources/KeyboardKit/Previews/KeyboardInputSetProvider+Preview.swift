//
//  KeyboardInputSetProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to preview keyboard views.
 */
public class PreviewKeyboardInputSetProvider: KeyboardInputSetProvider {
    
    public init() {}
    
    private lazy var context = PreviewKeyboardContext()
    private lazy var provider = StandardKeyboardInputSetProvider(context: context)
    
    public func alphabeticInputSet() -> AlphabeticKeyboardInputSet {
        provider.alphabeticInputSet()
    }
    
    public func numericInputSet() -> NumericKeyboardInputSet {
        provider.numericInputSet()
    }
    
    public func symbolicInputSet() -> SymbolicKeyboardInputSet {
        provider.symbolicInputSet()
    }
}
