//
//  ProPlaceholders.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-03-21.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit
#endif


// MARK: - Errors

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


// MARK: - Keyboard

public extension Keyboard {

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct BottomRow: View {
        public var body: some View {
            ProPlaceholderError.proPlaceholder
        }
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ToggleToolbar: View {
        public var body: some View {
            ProPlaceholderError.proPlaceholder
        }
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
public extension KeyboardInputViewController {

    /// 👑 This is unlocked by KeyboardKit Pro.
    typealias LicenseRegistrationResult = Result<License, Error>

    /// 👑 This is unlocked by KeyboardKit Pro.
    enum LicenseValidationErrorDisplay: Equatable {
        case debug, always
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    var hostApplicationBundleId: String? { nil }
}
#endif


// MARK: - Actions

public extension KeyboardAction.StandardActionHandler {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    func proReplacementActionWhenAppending(
        char: String
    ) -> KeyboardAction? {
        return nil
    }
}
    
    
// MARK: - Autocomplete

public extension Autocomplete {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class LocalAutocompleteService: Autocomplete.DisabledAutocompleteService {

        /// 👑 This is unlocked by KeyboardKit Pro.
        public var nextWordPredictionRequest: Autocomplete.NextWordPredictionRequest?
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    class RemoteAutocompleteService: Autocomplete.DisabledAutocompleteService {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    struct TextReplacementDictionary {

        public init() {}

        private let dictionary: Locale.Dictionary<[String: String]> = .init()
        
        /// 👑 This is unlocked by KeyboardKit Pro.
        static var additionalAutocorrections: Self { .init() }
    }
}

public extension AutocompleteSettings {

    /// 👑 This is unlocked by KeyboardKit Pro.
    var nextWordPredictionRequest: Autocomplete.NextWordPredictionRequest? { nil }
}

public extension Autocomplete.NextWordPredictionRequest {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func claude(
        apiKey: String,
        apiUrl: String = "",
        anthropicVersion: String = "",
        model: String = "",
        maxTokens: Int = 0,
        systemPrompt: String? = nil
    ) -> Self {
        .init(type: .claude) { _ in
            throw ProPlaceholderError.proPlaceholder
        } predictionParser: { _ in
            throw ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func openAI(
        apiKey: String,
        apiUrl: String = "",
        apiKeyHeader: String = "",
        apiKeyValuePrefix: String = "",
        model: String = "",
        maxTokens: Int = 0,
        systemPrompt: String? = nil
    ) -> Self {
        .init(type: .openAI) { _ in
            throw ProPlaceholderError.proPlaceholder
        } predictionParser: { _ in
            throw ProPlaceholderError.proPlaceholder
        }
    }
}

public extension AutocompleteService where Self == Autocomplete.LocalAutocompleteService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func local(
        context: AutocompleteContext,
        locale: Locale = .current
    ) throws -> Self {
        Autocomplete.LocalAutocompleteService()
    }
}


// MARK: - App

public extension KeyboardApp {

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct HomeScreen: View {
        public var body: some View {
            ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct LocaleScreen: View {
        public var body: some View {
            ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct SettingsScreen: View {
        public var body: some View {
            ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ThemeScreen: View {
        public var body: some View {
            ProPlaceholderError.proPlaceholder
        }
    }
}


// MARK: - Callouts

public extension KeyboardCallout {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class ProCalloutService: KeyboardCallout.BaseCalloutService {}
}

public extension KeyboardCallout.Actions {

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// > Note: This open-source function will always return
    /// standard English actions. The one in KeyboardKit Pro
    /// returns localized versions for all supported locales.
    static func standard(
        for action: KeyboardAction,
        context: KeyboardContext
    ) -> [KeyboardAction]? {
        KeyboardCallout.Actions.english.actions(for: action)
    }
}

public extension KeyboardCallout.ActionsBuilderParams {

    /// 👑 This is unlocked by KeyboardKit Pro.
    ///
    /// > Note: This open-source function will always return
    /// standard English actions. The one in KeyboardKit Pro
    /// returns localized versions for all supported locales.
    func standardActions(
        for context: KeyboardContext
    ) -> [KeyboardAction]? {
        KeyboardCallout.Actions.standard(for: action, context: context)
    }
}

public extension KeyboardCallout.ProCalloutService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class Swedish: KeyboardCallout.ProCalloutService {}
}

public extension KeyboardCalloutService where Self == KeyboardCallout.ProCalloutService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func localized(
        _ service: @autoclosure () throws -> KeyboardCallout.ProCalloutService
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
    struct BarVisualizer: View {
        public var body: some View {
            ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct BarVisualizerStyle {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct Screen: View {
        public var body: some View {
            ProPlaceholderError.proPlaceholder
        }
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    struct ScreenStyle {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class StandardDictationService: Dictation.DisabledDictationService {}
}

#if os(iOS)
public extension DictationService where Self == Dictation.StandardDictationService {

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

public extension Emoji {

    /// 👑 This is unlocked by KeyboardKit Pro.
    class ColonSearch {}
}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct EmojiKeyboard: View {
    public var body: some View {
        ProPlaceholderError.proPlaceholder
    }
}

/// 👑 This is unlocked by KeyboardKit Pro.
public extension Emoji.KeyboardStyle {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func standard(for context: KeyboardContext) -> Self {
        .init()
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func optimized(for context: KeyboardContext) -> Self {
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


// MARK: - Host

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardHostApplication {

    /// 👑 This is unlocked by KeyboardKit Pro.
    public func open(with actionHandler: KeyboardActionHandler) {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    public func open(with action: OpenURLAction) {}
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    public func openWithActionHandler(_ actionHandler: KeyboardActionHandler) {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    public func openWithAction(_ action: OpenURLAction) {}
}

/// 👑 This is unlocked by KeyboardKit Pro.
public protocol KeyboardHostApplicationProvider {

    var hostApplicationBundleId: String? { get }
    var hostApplication: KeyboardHostApplication? { get }
}


// MARK: - Input

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextField {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTextView {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct Vietnamese {}

/// 👑 This is unlocked by KeyboardKit Pro.
public struct VietnameseInputEngine {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    init() throws {}
}

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


// MARK: - Layout

public extension InputSet {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static var azerty: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static var colemak: InputSet {
        get throws {
            throw ProPlaceholderError.proPlaceholder
        }
    }
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    static var dvorak: InputSet {
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
    class ProLayoutService: KeyboardLayout.BaseLayoutService {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    class iPadProLayoutService: iPadLayoutService {}

    /// 👑 This is unlocked by KeyboardKit Pro.
    func adjusted(
        for displayMode: Keyboard.InputToolbarDisplayMode,
        layoutConfiguration: KeyboardLayout.DeviceConfiguration
    ) -> KeyboardLayout {
        return self
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    var bottomRowLayout: KeyboardLayout {
        var layout = self
        layout.itemRows = layout.itemRows.suffix(1)
        return layout
    }

    /// 👑 This is unlocked by KeyboardKit Pro.
    func copy() -> KeyboardLayout {
        .init(
            itemRows: itemRows,
            iPadProLayout: isIpadProLayout,
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

public extension KeyboardLayout.ProLayoutService {

    /// 👑 This is unlocked by KeyboardKit Pro
    class Swedish: KeyboardLayout.ProLayoutService {}
}

public extension KeyboardLayoutService where Self == KeyboardLayout.ProLayoutService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func localized(
        _ service: @autoclosure () throws -> KeyboardLayout.ProLayoutService
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


// MARK: - Licenses

/// 👑 This is unlocked by KeyboardKit Pro.
public struct License {}


// MARK: - Localization

public extension Locale {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    var supportedLayoutTypes: [Keyboard.LayoutType] {
        get throws { [] }
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
    class ThemeBasedStyleService: KeyboardStyle.StandardStyleService {}
}

public extension KeyboardStyleService where Self == KeyboardStyle.ThemeBasedStyleService {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static func themeBased(
        theme: @autoclosure () throws -> KeyboardTheme,
        keyboardContext: KeyboardContext
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }

    static func themeBased(
        keyboardContext: KeyboardContext,
        themeContext: KeyboardThemeContext
    ) throws -> Self {
        throw ProPlaceholderError.proPlaceholder
    }
}


// MARK: - Themes

/// 👑 This is unlocked by KeyboardKit Pro.
public struct KeyboardTheme: KeyboardModel {}

/// 👑 This is unlocked by KeyboardKit Pro.
public class KeyboardThemeContext: ObservableObject {
    
    /// 👑 This is unlocked by KeyboardKit Pro.
    public var settings: KeyboardThemeSettings { .init() }
}

/// 👑 This is unlocked by KeyboardKit Pro.
public class KeyboardThemeSettings: ObservableObject {

    /// 👑 This is unlocked by KeyboardKit Pro.
    public var theme: KeyboardTheme? { nil }
}

/// 👑 This is unlocked by KeyboardKit Pro.
public extension KeyboardTheme {

    /// 👑 This is unlocked by KeyboardKit Pro.
    static var predefined: [KeyboardTheme] {
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

public extension View {

    /// 👑 This is unlocked by KeyboardKit Pro.
    @ViewBuilder
    func keyboardTheme(
        _ theme: KeyboardTheme?,
        context: KeyboardContext
    ) -> some View {
        self
    }
}
