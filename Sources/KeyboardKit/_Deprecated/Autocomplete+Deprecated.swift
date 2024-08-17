import Foundation

@available(*, deprecated, renamed: "AutocompleteService")
public typealias AutocompleteProvider = AutocompleteService

public extension Autocomplete {

    @available(*, deprecated, renamed: "DisabledService")
    typealias DisabledProvider = DisabledService
}

@available(*, deprecated, renamed: "Autocomplete.Toolbar")
public typealias AutocompleteToolbar = Autocomplete.Toolbar

public extension AutocompleteContext {

    @available(*, deprecated, renamed: "isAutocompleteEnabled")
    var isEnabled: Bool {
        isAutocompleteEnabled
    }
}

public extension Autocomplete.Suggestion {

    @available(*, deprecated, message: "Use the type initializer instead.")
    init(
        text: String,
        title: String? = nil,
        isAutocorrect: Bool,
        subtitle: String? = nil,
        source: String? = nil,
        additionalInfo: [String: Any] = [:]
    ) {
        self.init(
            text: text,
            title: title,
            isAutocorrect: isAutocorrect,
            isUnknown: false,
            subtitle: subtitle,
            source: source,
            additionalInfo: additionalInfo
        )
    }

    @available(*, deprecated, message: "Use the type initializer instead.")
    init(
        text: String,
        title: String? = nil,
        isUnknown: Bool,
        subtitle: String? = nil,
        source: String? = nil,
        additionalInfo: [String: Any] = [:]
    ) {
        self.init(
            text: text,
            title: title,
            isAutocorrect: false,
            isUnknown: isUnknown,
            subtitle: subtitle,
            source: source,
            additionalInfo: additionalInfo
        )
    }

    @available(*, deprecated, message: "Use the type initializer instead.")
    init(
        text: String,
        title: String? = nil,
        isAutocorrect: Bool,
        isUnknown: Bool,
        subtitle: String? = nil,
        source: String? = nil,
        additionalInfo: [String: Any] = [:]
    ) {
        self.text = text
        self.title = title ?? text
        if isAutocorrect {
            self.type = .autocorrect
        } else if isUnknown {
            self.type = .unknown
        } else {
            self.type = .regular
        }
        self.subtitle = subtitle
        self.source = source
        self.additionalInfo = additionalInfo
    }
}
