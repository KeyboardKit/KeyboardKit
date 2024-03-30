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
public struct EmojiKeyboard {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct EmojiKeyboardStyle {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    public var itemFont: Font { .body }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static func standard(for context: KeyboardContext) -> Self {
        .init()
    }
}

/// 👑 This is unlocked by KeyboardKit Pro.
public class ExternalKeyboardContext: ObservableObject {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextField {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextView {}

/// 👑 This is unlocked by KeyboardKit Pro.
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
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    public struct Shelf {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    public struct ShelfItem {}
}

/// 👑 This is unlocked by KeyboardKit Pro.
public class ThemeBasedKeyboardStyleProvider {}

/// 👑 This is unlocked by KeyboardKit Pro.
public protocol SpeechRecognizer {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct SystemKeyboardPreview {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct SystemKeyboardButtonPreview {}


public extension Autocomplete {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class LocalProvider {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class RemoteProvider {}
}

public extension Dictation {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct BarVisualizer {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct BarVisualizerStyle {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    class ProService {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class ProKeyboardService {
        
        public func tryToReturnToKeyboard() {}
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Screen {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ScreenStyle {}
}

public extension Image {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static func emojiCategory(
        _ category: EmojiCategory
    ) throws -> Image {
        throw ProPlaceholderError.proPlaceholder
    }
}

public extension FeedbackConfiguration {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Toggle {}
}

public extension InputSet {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static var azerty: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    static var qwertz: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }
}

public extension Keyboard {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ToggleToolbar {}
}

public extension KeyboardLayout {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    class iPadProProvider: iPadProvider {}
}

public extension KeyboardStyleProvider {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static func themed(
        with theme: KeyboardTheme,
        context: KeyboardContext
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }
}

public extension Proxy {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct FullDocumentConfiguration {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct FullDocumentResult {
        
        /// The full document context before the input cursor.
        public var fullDocumentContextBeforeInput: String
        
        /// The full document context after the input cursor.
        public var fullDocumentContextAfterInput: String
    }
}

public extension View {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func dictationBarVisualizerStyle(
        _ style: Dictation.BarVisualizerStyle
    ) -> some View {
        EmptyView()
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func dictationScreenStyle(
        _ style: Dictation.ScreenStyle
    ) -> some View {
        EmptyView()
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func emojiKeyboardStyle(_ style: EmojiKeyboardStyle) -> some View {
        Text(ProPlaceholderError.proPlaceholder.localizedDescription)
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func keyboardDictation<Overlay: View>() -> some View {
        Text(ProPlaceholderError.proPlaceholder.localizedDescription)
    }
}


#if os(iOS) || os(tvOS) || os(visionOS)
public extension UITextDocumentProxy {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func fullDocumentContext(
        config: Proxy.FullDocumentConfiguration
    ) async throws -> Proxy.FullDocumentResult {
        throw ProPlaceholderError.proPlaceholder
    }
}
#endif
