import SwiftUI

@available(*, deprecated, renamed: "KeyboardBackspaceRange")
public typealias DeleteBackwardRange = KeyboardBackspaceRange

public extension KeyboardAction {

    @available(*, deprecated, renamed: "KeyboardReturnKeyType")
    typealias ReturnType = KeyboardReturnKeyType
    
    @available(*, deprecated, renamed: "shouldApplyAutocorrectSuggestion")
    var shouldApplyAutocompleteSuggestion: Bool {
        shouldApplyAutocorrectSuggestion
    }
}

@available(*, deprecated, renamed: "KeyboardAction.Rows")
public typealias KeyboardActionRows = KeyboardAction.Rows

@available(*, deprecated, renamed: "KeyboardAction.Row")
public typealias KeyboardActions = KeyboardAction.Row

@available(*, deprecated, message: "This is no longer used")
public extension KeyboardActions {

    init(
        imageNames: [String],
        keyboardImageNamePrefix keyboardPrefix: String = "",
        keyboardImageNameSuffix keyboardSuffix: String = "",
        localizationKeyPrefix keyPrefix: String = "",
        localizationKeySuffix keySuffix: String = "",
        throwAssertionFailure throwFailure: Bool = true
    ) {
        self = imageNames.map {
            .image(
                description: $0.translatedDescription(keyPrefix, keySuffix, throwFailure),
                keyboardImageName: "\(keyboardPrefix)\($0)\(keyboardSuffix)",
                imageName: $0)
        }
    }
}

private extension String {

    func translatedDescription(
        _ prefix: String,
        _ suffix: String,
        _ throwAssertionFailure: Bool) -> String {
        let key = "\(prefix)\(self)\(suffix)"
        let description = NSLocalizedString(key, comment: "")
        if key == description && throwAssertionFailure {
            assertionFailure("Translation is missing for \(self)")
        }
        return description
    }
}
