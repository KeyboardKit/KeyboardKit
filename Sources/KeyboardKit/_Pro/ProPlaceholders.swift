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

enum ProPlaceholderError: LocalizedError, View {
    
    case proPlaceholder
    case proView(_ name: String)
    
    var errorDescription: String {
        switch self {
        case .proPlaceholder: "👑 This is unlocked by KeyboardKit Pro."
        case .proView(let name): "👑 \(name) is unlocked by KeyboardKit Pro."
        }
    }
    
    var body: some View {
        Text(errorDescription)
    }
}

public extension Autocomplete {

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Autocomplete-Article> for more information.
    class LocalProvider {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Autocomplete-Article> for more information.
    class RemoteProvider {}
}

public extension Dictation {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Dictation-Article> for more information.
    struct BarVisualizer {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Dictation-Article> for more information.
    struct BarVisualizerStyle {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Dictation-Article> for more information.
    class ProService {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Dictation-Article> for more information.
    class ProKeyboardService {
        
        public func tryToReturnToKeyboard() {}
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Dictation-Article> for more information.
    struct Screen {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Dictation-Article> for more information.
    struct ScreenStyle {}
}
/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See <doc:Emojis-Article> for more information.
public struct EmojiKeyboard {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See <doc:Emojis-Article> for more information.
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

public extension FeedbackConfiguration {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Feedback-Article> for more information.
    struct Toggle {}
}

public extension Image {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Emojis-Article> for more information.
    static func emojiCategory(
        _ category: EmojiCategory
    ) throws -> Image {
        throw ProPlaceholderError.proPlaceholder
    }
}

public extension InputSet {

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Layout-Article> for more information.
    static var azerty: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Layout-Article> for more information.
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

public extension KeyboardApp {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct HomeScreen {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct HomeScreenStyle {}
}

public extension KeyboardLayout {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Layout-Article> for more information.
    class iPadProProvider: iPadProvider {}
}

public extension KeyboardStyle {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Themes-Article> for more information.
    class ThemeBasedProvider {}
}

public extension KeyboardStyleProvider {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// See <doc:Themes-Article> for more information.
    static func themed(
        with theme: KeyboardTheme,
        context: KeyboardContext
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }
}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextField {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextView {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See <doc:Themes-Article> for more information.
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

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See <doc:Dictation-Article> for more information.
public protocol SpeechRecognizer {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See <doc:Previews-Article> for more information.
public struct SystemKeyboardPreview {}

/// 👑 This is unlocked by KeyboardKit Pro.
///
/// See <doc:Previews-Article> for more information.
public struct SystemKeyboardButtonPreview {}

@available(*, deprecated, renamed: "KeyboardStyle.ThemeBasedProvider")
public typealias ThemeBasedKeyboardStyleProvider = KeyboardStyle.StandardProvider

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

public extension View {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func dictationBarVisualizerStyle(_ style: Dictation.BarVisualizerStyle) -> some View {
        ProPlaceholderError.proView(".dictationBarVisualizerStyle")
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func dictationScreenStyle(_ style: Dictation.ScreenStyle) -> some View {
        ProPlaceholderError.proView(".dictationScreenStyle")
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func emojiKeyboardStyle(_ style: EmojiKeyboardStyle) -> some View {
        ProPlaceholderError.proView(".emojiKeyboardStyle")
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func keyboardAppHomeScreenStyle(_ style: KeyboardApp.HomeScreenStyle) -> some View {
        ProPlaceholderError.proView(".keyboardAppHomeScreenStyle")
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func keyboardDictation<Overlay: View>() -> some View {
        ProPlaceholderError.proView(".keyboardDictation")
    }
}
