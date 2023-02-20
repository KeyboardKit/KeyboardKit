//
//  KeyboardAction+KeyboardActions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This typealias represents a ``KeyboardAction`` array.

 The typealias makes it easier to create and handle keyboard
 action rows and collections.
 */
public typealias KeyboardActions = [KeyboardAction]

public extension KeyboardActions {

    /**
     Create keyboard actions by mapping strings to a list of
     ``KeyboardAction/character(_:)`` actions.
    */
    init(characters: [String]) {
        self = characters.map { .character($0) }
    }

    /**
     Create keyboard actions by mapping image names to a set
     of ``KeyboardAction/image(description:keyboardImageName:imageName:)``
     actions, using certain name prefix and suffix rules.

     The optional keyboard image and localization key prefix
     and suffix parameters can be used to generate different
     names for each image name in the image names array. For
     instance, using `emoji-` as a `keyboardImageNamePrefix`
     will generate an image action where `keyboardName` will
     prefixed with `emoji-`.

     The localization keys parameters are optional, but will
     be used to improve the overall image accessibility.

     `throwAssertionFailure` will cause your app to crash in
     debug if a translation can't be retrieved for a certain
     image. This helps you assert that all image actions are
     accessible. It's `true` by default.
     */
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

public extension KeyboardActions {

    /**
     Get the leading character margin action.
     */
    var leadingCharacterMarginAction: KeyboardAction {
        characterMarginAction(for: first { $0.isInputAction })
    }

    /**
     Get the trailing character margin action.
     */
    var trailingCharacterMarginAction: KeyboardAction {
        characterMarginAction(for: last { $0.isInputAction })
    }

    /**
     Get a margin action for a certain action, if any.

     This function returns `characterMargin` for `character`
     and `none` for all other action types.
     */
    func characterMarginAction(for action: KeyboardAction?) -> KeyboardAction {
        guard let action = action else { return .none }
        switch action {
        case .character(let char): return .characterMargin(char)
        default: return .none
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
