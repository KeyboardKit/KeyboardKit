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
    case proFeature(_ name: String)
    
    var errorDescription: String {
        switch self {
        case .proPlaceholder: "👑 This is unlocked by KeyboardKit Pro."
        case .proFeature(let name): "👑 \(name) is unlocked by KeyboardKit Pro."
        }
    }
    
    var body: some View {
        Text(errorDescription)
    }
}

public extension Autocomplete {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class LocalService: Autocomplete.DisabledService {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class RemoteService: Autocomplete.DisabledService {}
}

public extension AutocompleteService where Self == Autocomplete.LocalService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func local(
        context: AutocompleteContext,
        locale: Locale = .current
    ) throws -> Self {
        Autocomplete.LocalService()
    }
}

public extension Callouts {

    /// 👑 This is unlocked by KeyboardKit Pro
    class ProService: Callouts.DisabledService {}
}

public extension Callouts.ProService {

    /// 👑 This is unlocked by KeyboardKit Pro
    class Swedish: Callouts.ProService {}
}

public extension CalloutService where Self == Callouts.ProService {

    /// 👑 This is unlocked by KeyboardKit Pro
    static func localized(
        for locale: KeyboardLocale
    ) throws -> Self {
        Callouts.ProService.Swedish()
    }
}

public extension Dictation {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct BarVisualizer {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct BarVisualizerStyle {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    class ProService: Dictation.DisabledService {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class ProKeyboardService: Dictation.DisabledKeyboardService {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Screen {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ScreenStyle {}
}

#if os(iOS)
public extension DictationService where Self == Dictation.ProService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func pro(
        context: DictationContext,
        speechRecognizer: Any,
        result: @escaping (String) -> Void
    ) throws -> Self {
        Dictation.ProService()
    }
}

public extension KeyboardDictationService where Self == Dictation.ProKeyboardService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func proInKeyboard(
        keyboardContext: KeyboardContext,
        dictationContext: DictationContext,
        actionHandler: KeyboardActionHandler
    ) throws -> Self {
        Dictation.ProKeyboardService(context: dictationContext)
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func proInApp(
        dictationContext: DictationContext,
        openUrl: OpenURLAction?,
        speechRecognizer: Any
    ) throws -> Self {
        Dictation.ProKeyboardService(context: dictationContext)
    }
}
#endif


/// 👑 This is unlocked by KeyboardKit Pro.
public struct EmojiKeyboard {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct EmojiKeyboardStyle {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    public var itemFont: Font { .body }

    /// 👑 This is unlocked by KeyboardKit Pro.
    public var itemScaleFactor: Double { 1.0 }

    /// 👑 This is unlocked by KeyboardKit Pro.
    public var itemSize: Double { 1.0 }

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func standard(for context: KeyboardContext) -> Self {
        .init()
    }
}

/// 👑 This is unlocked by KeyboardKit Pro.
public class ExternalKeyboardContext: ObservableObject {}

public extension Feedback {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Toggle {}
}

public extension Image {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static func emojiCategory(
        _ category: EmojiCategory
    ) throws -> Image {
        throw ProPlaceholderError.proPlaceholder
    }
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
    struct ButtonPreview {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ToggleToolbar {}
}

public extension KeyboardApp {

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct HomeScreen {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct LocaleScreen {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct SettingsScreen {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ThemeScreen {}
}

/// 👑 This is unlocked by KeyboardKit Pro.
public enum KeyboardHostApplication {}

/// 👑 This is unlocked by KeyboardKit Pro.
public protocol KeyboardHostApplicationProvider {

    var hostApplicationBundleId: String? { get }
    var hostApplication: KeyboardHostApplication? { get }
}

public extension KeyboardLayout {

    /// 👑 This is unlocked by KeyboardKit Pro
    class ProService: KeyboardLayout.DisabledService {}

    struct Test {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class iPadProService: iPadService {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    func adjusted(
        for displayMode: Keyboard.InputToolbarDisplayMode,
        layoutConfiguration: KeyboardLayout.Configuration
    ) -> KeyboardLayout {
        return self
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func copy() -> KeyboardLayout {
        .init(
            itemRows: itemRows,
            iPadProLayout: ipadProLayout,
            idealItemHeight: idealItemHeight,
            idealItemInsets: idealItemInsets
        )
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func createIdealItem(
        for action: KeyboardAction,
        width: KeyboardLayout.ItemWidth = .available,
        alignment: Alignment = .center
    ) -> KeyboardLayout.Item {
        .init(
            action: action,
            size: .init(width: width, height: idealItemHeight),
            alignment: alignment,
            edgeInsets: idealItemInsets
        )
    }
}

public extension KeyboardLayout.ProService {

    /// 👑 This is unlocked by KeyboardKit Pro
    class Swedish: KeyboardLayout.ProService {}
}

public extension KeyboardLayoutService where Self == KeyboardLayout.ProService {

    /// 👑 This is unlocked by KeyboardKit Pro
    static func localized(
        for locale: KeyboardLocale
    ) throws -> Self {
        KeyboardLayout.ProService.Swedish()
    }
}

public extension KeyboardStatus {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Section: View {
        public var body: some View {
            EmptyView()
        }
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct SectionStyle {}
}

public extension KeyboardStyle {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    class ThemeBasedService: KeyboardStyle.StandardService {}
}

public extension KeyboardStyleService where Self == KeyboardStyle.ThemeBasedService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    func themeBased(
        theme: @autoclosure () throws -> KeyboardTheme,
        keyboardContext: KeyboardContext
    ) throws -> Self {
        .init(keyboardContext: keyboardContext)
    }
}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextField {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextView {}

/// 👑 This is unlocked by KeyboardKit Pro.
public extension KeyboardTheme {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static var allPredefined: [KeyboardTheme] {
        get throws { throw ProPlaceholderError.proPlaceholder }
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static var standard: KeyboardTheme {
        get throws { throw ProPlaceholderError.proPlaceholder }
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static var swifty: KeyboardTheme {
        get throws { throw ProPlaceholderError.proPlaceholder }
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static var minimal: KeyboardTheme {
        get throws { throw ProPlaceholderError.proPlaceholder }
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct StandardStyle: KeyboardThemeStyleVariation {
    
        /// 👑 This is unlocked by KeyboardKit Pro.
        public static let standard = Self()
        
        /// 👑 This is unlocked by KeyboardKit Pro.
        public static let blue = Self()
        
        /// 👑 This is unlocked by KeyboardKit Pro.
        public static let green = Self()
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Shelf {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ShelfItem {}
}
    
/// 👑 This is unlocked by KeyboardKit Pro.
public protocol KeyboardThemeStyleVariation {}

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
public protocol SpeechRecognizer {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardViewPreview {}

@available(*, deprecated, renamed: "KeyboardStyle.ThemeBasedService")
public typealias ThemeBasedKeyboardStyleProvider = KeyboardStyle.StandardService

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
        self
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func dictationScreenStyle(_ style: Dictation.ScreenStyle) -> some View {
        self
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func emojiKeyboardStyle(
        _ style: EmojiKeyboardStyle
    ) -> some View {
        self
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 9.0, *)
    func focused<DoneButton: View>(
        _ value: FocusState<Bool>.Binding,
        @ViewBuilder doneButton: @escaping () -> DoneButton
    ) -> some View { self }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func keyboardDictation<Overlay: View>() -> some View {
        self
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func keyboardStatusSectionStyle(
        _ style: KeyboardStatus.SectionStyle
    ) -> some View {
        self
    }
}
