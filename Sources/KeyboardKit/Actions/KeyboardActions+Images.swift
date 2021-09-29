//
//  KeyboardActions+Images.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardActions {
    
    /**
     Create keyboard actions by mapping image names to a set
     of `.image` actions, using certain name matching prefix
     and suffix rules.
     
     `keyboardImageNamePrefix` and `keyboardImageNameSuffix`
     are used to map an `imageName` to a `keyboardImageName`.
     For instance, if you provide an `emoji-` prefix but let
     the suffix be empty, an action an `imageName` of `heart`
     will have `emoji-heart` as `keyboardImageName`.
     
     The `localizationKey` prefix and suffix are used to map
     an `imageName` to a localization key. This is then used
     to get a translated `description` for each image, which
     for instance can be used for accessibility labels.
     
     `throwAssertionFailure` will cause your app to crash in
     development, whenever a translated description can't be
     generated for an image. It is `true` by default.
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
