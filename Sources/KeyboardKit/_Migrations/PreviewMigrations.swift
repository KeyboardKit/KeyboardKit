import SwiftUI

public extension KeyboardPreviews {

    @available(*, deprecated, renamed: "ActionHandler", message: "Migration Deprecation, will be removed in 9.1!")
    typealias PreviewKeyboardActionHandler = ActionHandler

    @available(*, deprecated, renamed: "AutocompleteService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias PreviewKeyboardAutocompleteService = AutocompleteService

    @available(*, deprecated, renamed: "CalloutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias PreviewKeyboardCalloutService = CalloutService

    @available(*, deprecated, renamed: "LayoutService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias PreviewKeyboardLayoutService = LayoutService

    @available(*, deprecated, renamed: "StyleService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias PreviewKeyboardStyleService = StyleService

    #if os(iOS)
    @available(*, deprecated, renamed: "InputViewController", message: "Migration Deprecation, will be removed in 9.1!")
    typealias PreviewKeyboardInputViewController = InputViewController

    @available(*, deprecated, renamed: "TextDocumentProxy", message: "Migration Deprecation, will be removed in 9.1!")
    typealias PreviewTextDocumentProxy = TextDocumentProxy
    #endif
}
