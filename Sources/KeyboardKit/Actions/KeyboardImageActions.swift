//
//  KeyboardImageActions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This model represents a collection of `Image` actions. It's
 an easy way to create a set of actions from a list of image
 names, e.g. when creating an image-only emoji keyboard.
 */
public struct KeyboardImageActions {
    
    /**
     Create an instance using image names and various params.
     
     The `keyboardImageName` prefix and suffix are used when
     mapping each `imageName` to a `keyboardImageName`. This
     name can thus have a different name than the image name.
     For instance, if you provide an `emoji-` prefix but let
     the suffix be empty, an action that has the `imageName`
     set to `heart` will have a `keyboardImageName` with the
     value `emoji-heart`.
     
     The `localizationKey` prefix and suffix are used to map
     each `imageName` to a localization key, just like it is
     done for the `keyboardImageName`. This localization key
     is then used to get a translated `description` for each
     image. For instance, the description of an action where
     `imageName` is `heart` may be `Heart`. This description
     can e.g. be used for accessibility.
     
     `throwAssertionFailure` is a good way to crash your app
     in development, if any image doesn't have a description
     translation. It is `true` by default.
     */
    public init(
        imageNames: [String],
        keyboardImageNamePrefix keyboardPrefix: String = "",
        keyboardImageNameSuffix keyboardSuffix: String = "",
        localizationKeyPrefix keyPrefix: String = "",
        localizationKeySuffix keySuffix: String = "",
        throwAssertionFailure throwFailure: Bool = true) {
        actions = imageNames.map {
            .image(
                description: $0.translatedDescription(keyPrefix, keySuffix, throwFailure),
                keyboardImageName: "\(keyboardPrefix)\($0)\(keyboardSuffix)",
                imageName: $0)
        }
    }
    
    public let actions: [KeyboardAction]
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
