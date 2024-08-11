import Foundation
import SwiftUI

public extension AutocompleteContext {

    /// DEPRECATED!
    ///
    /// > Warning: Settings have been moved into the context.
    /// This will be removed in KeyboardKit 9.0.
    func sync(with settings: AutocompleteSettings) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: settings)
        }
    }
}

extension AutocompleteContext {

    func syncAfterAsync(with settings: AutocompleteSettings) {
        if suggestionsDisplayCount != settings.suggestionsDisplayCount {
            suggestionsDisplayCount = settings.suggestionsDisplayCount
        }
        if isAutocompleteEnabled != settings.isAutocompleteEnabled {
            isAutocompleteEnabled = settings.isAutocompleteEnabled
        }
        if isAutocorrectEnabled != settings.isAutocorrectEnabled {
            isAutocorrectEnabled = settings.isAutocorrectEnabled
        }
    }
}
