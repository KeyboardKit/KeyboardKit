//
//  KeyboardAction+KeyboardActions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This typealias represents a ``KeyboardAction`` array.
 
 The typealias makes it easier to create and handle keyboard
 action collections.
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
     names for every image name in the provided `imageNames`
     array. For instance, providing a `emoji-` string as the
     `keyboardImageNamePrefix` will generate an image action
     where the `keyboardName` is prefixed with `emoji`.
     
     The localization keys are optional, but will be used to
     improve the overall accessibility of the keyboard image.
     
     `throwAssertionFailure` will cause your app to crash in
     debug if a translation can't be retrieved for a certain
     image. This helps you assert that all image actions are
     accessible. It is `true` by default.
     */
    init(
        imageNames: [String],
        keyboardImageNamePrefix keyboardPrefix: String = "",
        keyboardImageNameSuffix keyboardSuffix: String = "",
        localizationKeyPrefix keyPrefix: String = "",
        localizationKeySuffix keySuffix: String = "",
        throwAssertionFailure throwFailure: Bool = true) {
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
