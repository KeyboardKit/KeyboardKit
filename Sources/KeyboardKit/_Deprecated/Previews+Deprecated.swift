import Foundation

@available(*, deprecated, renamed: "KeyboardPreviews.ActionHandler")
public typealias PreviewKeyboardActionHandler = KeyboardPreviews.ActionHandler

@available(*, deprecated, renamed: "KeyboardPreviews.LayoutProvider")
public typealias PreviewKeyboardLayoutProvider = KeyboardPreviews.LayoutProvider

@available(*, deprecated, renamed: "KeyboardPreviews.StyleProvider")
public typealias PreviewKeyboardStyleProvider = KeyboardPreviews.StyleProvider

#if os(iOS) || os(tvOS)
@available(*, deprecated, renamed: "KeyboardPreviews.TextDocumentProxy")
public typealias PreviewTextDocumentProxy = KeyboardPreviews.TextDocumentProxy
#endif
