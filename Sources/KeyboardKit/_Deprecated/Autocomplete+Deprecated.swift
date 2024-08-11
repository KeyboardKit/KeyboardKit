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
