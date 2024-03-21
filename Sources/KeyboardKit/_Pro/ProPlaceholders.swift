//
//  ProPlaceholders.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-21.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit
#endif


public enum ProPlaceholderError: LocalizedError {
    
    case proPlaceholder
    
    public var errorDescription: String? {
        "This is unlocked by KeyboardKit Pro."
    }
}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct EmojiKeyboard {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct EmojiKeyboardStyle {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class ExternalKeyboardContext: ObservableObject {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class iPadProKeyboardLayoutProvider: iPadKeyboardLayoutProvider {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct KeyboardTextField {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct KeyboardTheme {}

/// This type is unlocked by KeyboardKit Pro.
/// 
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class LocalAutocompleteProvider {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class ProDictationService {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class ProKeyboardDictationService {
    
    public func tryToReturnToKeyboard() {}
}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class RemoteAutocompleteProvider {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public protocol SpeechRecognizer {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct SystemKeyboardPreview {}

/// This type is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct SystemKeyboardButtonPreview {}


public extension Dictation {
    
    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    struct BarVisualizer {}
    
    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    struct Screen {}
}


public extension Image {
    
    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    static func emojiCategory(
        _ category: EmojiCategory
    ) throws -> Image {
        throw ProPlaceholderError.proPlaceholder
    }
}


public extension InputSet {

    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    static var azerty: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }

    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    static var qwertz: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }
}


public extension Proxy {
    
    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    struct FullDocumentConfiguration {}
    
    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    struct FullDocumentResult {
        
        /// The full document context before the input cursor.
        public var fullDocumentContextBeforeInput: String
        
        /// The full document context after the input cursor.
        public var fullDocumentContextAfterInput: String
    }
}


public extension View {
    
    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    func emojiKeyboardStyle(_ style: EmojiKeyboardStyle) -> some View {
        Text(ProPlaceholderError.proPlaceholder.localizedDescription)
    }
    
    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    func keyboardDictation<Overlay: View>() -> some View {
        Text(ProPlaceholderError.proPlaceholder.localizedDescription)
    }
}


#if os(iOS) || os(tvOS) || os(visionOS)
public extension UITextDocumentProxy {
    
    /// This type is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    func fullDocumentContext(
        config: Proxy.FullDocumentConfiguration
    ) async throws -> Proxy.FullDocumentResult {
        throw ProPlaceholderError.proPlaceholder
    }
}
#endif
