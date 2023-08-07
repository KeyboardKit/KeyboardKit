import Foundation

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public enum AutocompleteSpaceState {
    case none
    case autoInserted
    case autoRemoved
}

public extension AutocompleteSuggestion {
    
    @available(*, deprecated, message: "isAutocomplete has been renamed to isAutocorrect")
    init(
        text: String,
        title: String? = nil,
        isAutocomplete: Bool,
        isUnknown: Bool = false,
        subtitle: String? = nil,
        additionalInfo: [String: Any] = [:]
    ) {
        self.text = text
        self.title = title ?? text
        self.isAutocorrect = isAutocomplete
        self.isUnknown = isUnknown
        self.subtitle = subtitle
        self.additionalInfo = additionalInfo
    }
    
    @available(*, deprecated, renamed: "isAutocorrect")
    var isAutocomplete: Bool { isAutocorrect }
}

@available(*, deprecated, renamed: "KeyboardStyle.AutocompleteToolbar")
public typealias AutocompleteToolbarStyle = KeyboardStyle.AutocompleteToolbar

public extension KeyboardStyle.AutocompleteToolbar {
    
    @available(*, deprecated, message: "autocompleteBackground has been renamed to autocorrectBackground.")
    init(
        height: CGFloat? = 50,
        item: KeyboardStyle.AutocompleteToolbarItem = .standard,
        separator: KeyboardStyle.AutocompleteToolbarSeparator = .standard,
        autocompleteBackground: KeyboardStyle.AutocompleteToolbarItemBackground
    ) {
        self.init(
            height: height,
            item: item,
            separator: separator,
            autocorrectBackground: autocompleteBackground
        )
    }

    @available(*, deprecated, renamed: "autocorrectBackground")
    var autocompleteBackground: KeyboardStyle.AutocompleteToolbarItemBackground {
        get { autocorrectBackground }
        set { autocorrectBackground = newValue }
    }
}

@available(*, deprecated, renamed: "KeyboardStyle.AutocompleteToolbarItem")
public typealias AutocompleteToolbarItemStyle = KeyboardStyle.AutocompleteToolbarItem

@available(*, deprecated, renamed: "KeyboardStyle.AutocompleteToolbarItemBackground")
public typealias AutocompleteToolbarItemBackgroundStyle = KeyboardStyle.AutocompleteToolbarItemBackground

@available(*, deprecated, renamed: "KeyboardStyle.AutocompleteToolbarSeparator")
public typealias AutocompleteToolbarSeparatorStyle = KeyboardStyle.AutocompleteToolbarSeparator

@available(*, deprecated, message: "This will be removed in KeyboardKit 8.0")
public protocol PrefersAutocompleteResolver {

    var prefersAutocomplete: Bool { get }
}
