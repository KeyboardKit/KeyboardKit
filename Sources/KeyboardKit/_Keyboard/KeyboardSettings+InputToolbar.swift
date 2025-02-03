//
//  KeyboardSettings+InputToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-11.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardSettings {
    
    /// This enum defines various input toolbar modes, which
    /// can be used to set how an input toolbar is displayed.
    ///
    /// Unlike the ``Keyboard/InputToolbarDisplayMode`` type,
    /// this type is used by ``KeyboardSettings``, which can
    /// then resolve display modes based on other properties.
    ///
    /// You can apply a display mode using the view modifier
    /// ``SwiftUICore/View/keyboardInputToolbarDisplayMode(_:)``.
    enum InputToolbarType: String, KeyboardModel {

        /// Display a toolbar based on the native behavior.
        case automatic

        /// Display a fixed set of characters from settings.
        case characters
        
        /// Display contextual numbers or symbols.
        case numbers
        
        /// Display the most recently used emojis.
        case recentEmojis

        /// Remove the input toolbar altogether.
        case none
    }
    
    /// The input toolbar display mode.
    ///
    /// This value is derived from ``inputToolbarType``, and
    /// uses ``inputToolbarCharacters`` for input characters.
    var inputToolbarDisplayMode: Keyboard.InputToolbarDisplayMode {
        switch inputToolbarType {
        case .automatic: return .automatic
        case .characters: return .characters(charactersString)
        case .numbers: return .numbers
        case .recentEmojis: return .characters(recentEmojisString)
        case .none: return .none
        }
    }
}

private extension KeyboardSettings {
    
    var maxLength: Int {
        inputToolbarCharactersMaxLength
    }
    
    var charactersString: String {
        inputToolbarCharacters.inputToolbarCapped(maxLength)
    }

    var recentEmojisString: String {
        let recentString = EmojiCategory.recent
            .emojis
            .prefix(10)
            .map { $0.char }.joined()
        let placeholders = "😀🤩😍😂👍👎👋🙌🙏❤️"
        let joined = recentString + placeholders
        return joined.inputToolbarCapped(maxLength)
    }
}

private extension String {
    
    func inputToolbarCapped(_ count: Int) -> String {
        String(self.prefix(count))
    }
}
