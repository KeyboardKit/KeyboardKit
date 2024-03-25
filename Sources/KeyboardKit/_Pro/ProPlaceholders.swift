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


enum ProPlaceholderError: LocalizedError {
    
    case proPlaceholder
    
    var errorDescription: String? {
        "👑 This is unlocked by KeyboardKit Pro."
    }
}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct EmojiKeyboard {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct EmojiKeyboardStyle {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class ExternalKeyboardContext: ObservableObject {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class iPadProKeyboardLayoutProvider: iPadKeyboardLayoutProvider {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct KeyboardTextField {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct KeyboardTextView {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct KeyboardTheme {
    
    public static var allPredefined: [KeyboardTheme] {
        get throws { throw ProPlaceholderError.proPlaceholder }
    }
    
    public static var standard: KeyboardTheme {
        get throws { throw ProPlaceholderError.proPlaceholder }
    }
    
    public static var swifty: KeyboardTheme {
        get throws { throw ProPlaceholderError.proPlaceholder }
    }
    
    public static var minimal: KeyboardTheme {
        get throws { throw ProPlaceholderError.proPlaceholder }
    }
}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class ThemeBasedKeyboardStyleProvider {}

/// 👑 This is unlocked by KeyboardKit Pro.
/// 
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class LocalAutocompleteProvider {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class ProDictationService {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class ProKeyboardDictationService {
    
    public func tryToReturnToKeyboard() {}
}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public class RemoteAutocompleteProvider {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public protocol SpeechRecognizer {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
public struct SystemKeyboardPreview {}

/// 👑 This is unlocked by KeyboardKit Pro.
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

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    static var azerty: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    static var qwertz: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }
}


public extension KeyboardStyleProvider {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    static func themed(
        with theme: KeyboardTheme,
        context: KeyboardContext
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }
}


public extension Proxy {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    struct FullDocumentConfiguration {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
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
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    func emojiKeyboardStyle(_ style: EmojiKeyboardStyle) -> some View {
        Text(ProPlaceholderError.proPlaceholder.localizedDescription)
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    func keyboardDictation<Overlay: View>() -> some View {
        Text(ProPlaceholderError.proPlaceholder.localizedDescription)
    }
}


#if os(iOS) || os(tvOS) || os(visionOS)
public extension UITextDocumentProxy {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See [KeyboardKit Pro](https://github.com/Keyboard/KeyboardKitPro) for more information.
    func fullDocumentContext(
        config: Proxy.FullDocumentConfiguration
    ) async throws -> Proxy.FullDocumentResult {
        throw ProPlaceholderError.proPlaceholder
    }
}
#endif
