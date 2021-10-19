//
//  KeyboardInputSetProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardInputSetProvider where Self == PreviewKeyboardInputSetProvider {
    
    /**
     This preview provider can be used in SwiftUI previews.
     */
    static var preview: KeyboardInputSetProvider { PreviewKeyboardInputSetProvider() }
}

/**
 This input set provider can be used in SwiftUI previews.
 */
public class PreviewKeyboardInputSetProvider: KeyboardInputSetProvider {
    
    public init(context: KeyboardContext = .preview) {
        self.context = context
        self.provider = StandardKeyboardInputSetProvider(context: context)
    }
    
    private let context: KeyboardContext
    private let provider: KeyboardInputSetProvider
    
    /**
     Get the alphabetic input set to use.
     */
    public var alphabeticInputSet: AlphabeticKeyboardInputSet {
        provider.alphabeticInputSet
    }
    
    /**
     Get the numeric input set to use.
     */
    public var numericInputSet: NumericKeyboardInputSet {
        provider.numericInputSet
    }
    
    /**
     Get the symbolic input set to use.
     */
    public var symbolicInputSet: SymbolicKeyboardInputSet {
        provider.symbolicInputSet
    }
}
