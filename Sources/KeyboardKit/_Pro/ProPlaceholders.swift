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

/// 👑 This is unlocked by KeyboardKit Pro.
public struct License {}


// MARK: - Essential

public extension Keyboard {

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ToggleToolbar {}
}

#if os(iOS)
public extension KeyboardInputViewController {

    /// 👑 This is unlocked by KeyboardKit Pro.
    typealias LicenseRegistrationResult = Result<License, Error>

    /// 👑 This is unlocked by KeyboardKit Pro.
    func setupPro(
        for app: KeyboardApp,
        completion: @escaping (LicenseRegistrationResult) -> Void
    ) {}
}
#endif


// MARK: - Autocomplete

public extension Autocomplete {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class LocalService: Autocomplete.DisabledService {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class RemoteService: Autocomplete.DisabledService {}
}

public extension Autocomplete.NextWordPredictionRequest {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func claude(
        apiKey: String,
        apiVersion: String = "2023-06-01",
        apiUrl: String = "https://api.anthropic.com/v1/messages",
        model: String = "claude-3-5-sonnet-20240620",
        maxTokens: Int = 15,
        system: String = "You are a next word predictor. ONLY return the 3 most probable next words as CSV."
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }
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


// MARK: - App

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


// MARK: - Callouts

public extension Callouts {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class ProService: Callouts.DisabledService {}
}

public extension Callouts.ProService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class Swedish: Callouts.ProService {}
}

public extension CalloutService where Self == Callouts.ProService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func localized(
        _ service: @autoclosure () throws -> Callouts.ProService
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func localized(
        for locale: Locale
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }
}


// MARK: - Dictation

public extension Dictation {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct BarVisualizer {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct BarVisualizerStyle {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Screen {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ScreenStyle {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class StandardService: Dictation.DisabledService {}
}

#if os(iOS)
public extension DictationService where Self == Dictation.StandardService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func standardInApp(
        dictationContext: DictationContext,
        keyboardContext: KeyboardContext,
        openUrl: OpenURLAction,
        speechRecognizer: DictationSpeechRecognizer
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func standardInKeyboard(
        dictationContext: DictationContext,
        keyboardContext: KeyboardContext,
        actionHandler: KeyboardActionHandler
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }
}
#endif

/// 👑 This is unlocked by KeyboardKit Pro.
public protocol DictationSpeechRecognizer {}

public extension View {

    /// 👑 This is unlocked by KeyboardKit Pro.
    func dictationBarVisualizerStyle(_ style: Dictation.BarVisualizerStyle) -> some View {
        self
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    func dictationScreenStyle(_ style: Dictation.ScreenStyle) -> some View {
        self
    }
}


// MARK: - Emojis

/// 👑 This is unlocked by KeyboardKit Pro.
public struct EmojiKeyboard {}

/// 👑 This is unlocked by KeyboardKit Pro.
public extension Emoji.KeyboardStyle {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func standard(for context: KeyboardContext) -> Self {
        .init()
    }
}

public extension Image {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func emojiCategory(
        _ category: EmojiCategory
    ) throws -> Image {
        throw ProPlaceholderError.proPlaceholder
    }
}


// MARK: - External

/// 👑 This is unlocked by KeyboardKit Pro.
public class ExternalKeyboardContext: ObservableObject {}


// MARK: - Feedback

public extension Feedback {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Toggle {}
}


// MARK: - Host

/// 👑 This is unlocked by KeyboardKit Pro.
public enum KeyboardHostApplication {}

/// 👑 This is unlocked by KeyboardKit Pro.
public protocol KeyboardHostApplicationProvider {

    var hostApplicationBundleId: String? { get }
    var hostApplication: KeyboardHostApplication? { get }
}


// MARK: - Layout

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

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func localized(
        _ service: @autoclosure () throws -> KeyboardLayout.ProService
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }

    /// 👑 This is unlocked by KeyboardKit Pro
    static func localized(
        for locale: Locale
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }
}


// MARK: - Previews

public extension Keyboard {

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ButtonPreview {}
}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardViewPreview {}


// MARK: - Proxy

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


// MARK: - Status

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


// MARK: - Styling

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


// MARK: - Text Input

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextField {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextView {}

public extension View {

    /// 👑 This is unlocked by KeyboardKit Pro.
    func focused<DoneButton: View>(
        _ value: FocusState<Bool>.Binding,
        @ViewBuilder doneButton: @escaping () -> DoneButton
    ) -> some View { self }
    /// 👑 This is unlocked by KeyboardKit Pro.
    func keyboardStatusSectionStyle(
        _ style: KeyboardStatus.SectionStyle
    ) -> some View {
        self
    }
}


// MARK: - Themes

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
