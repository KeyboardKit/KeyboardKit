//
//  File.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-01-31.
//

import Foundation

public extension Keyboard {
    
    @available(*, deprecated, renamed: "KeyboardSettings")
    typealias Settings = KeyboardSettings
}

public extension KeyboardContext {
    
    @available(*, deprecated, message: "Just use KeyboardSettings.")
    typealias Settings = KeyboardSettings
}


public extension Autocomplete {
    
    @available(*, deprecated, renamed: "AutocompleteSettings")
    typealias Settings = AutocompleteSettings
}

public extension AutocompleteContext {
    
    @available(*, deprecated, message: "Just use AutocompleteSettings.")
    typealias Settings = AutocompleteSettings
}


public extension Dictation {
    
    @available(*, deprecated, renamed: "DictationSettings")
    typealias Settings = DictationSettings
}

public extension DictationContext {
    
    @available(*, deprecated, message: "Just use DictationSettings.")
    typealias Settings = DictationSettings
}


public extension KeyboardFeedback {
    
    @available(*, deprecated, renamed: "KeyboardFeedbackSettings")
    typealias Settings = KeyboardFeedbackSettings
}

public extension KeyboardFeedbackContext {
    
    @available(*, deprecated, message: "Just use KeyboardFeedbackSettings.")
    typealias Settings = KeyboardFeedbackSettings
}



public extension KeyboardTheme {
    
    @available(*, deprecated, renamed: "KeyboardThemeSettings")
    typealias Settings = KeyboardThemeSettings
}

public extension KeyboardThemeContext {
    
    @available(*, deprecated, message: "Just use KeyboardThemeSettings.")
    typealias Settings = KeyboardThemeSettings
}
