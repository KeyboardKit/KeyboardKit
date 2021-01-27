//
//  KeyboardActions+Image.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Array where Element == KeyboardAction {
    
    /**
     Map a list of image names to a list of `.image` actions,
     using certain image name matching prefixes and suffixes.
     
     The `keyboardImageNamePrefix` and `Suffix` are used for
     mapping each `imageName` to a `keyboardImageName`. This
     name can be different from the image name. For instance,
     if you provide an `emoji-` prefix but let the suffix be
     empty, an action that has the `imageName` set to `heart`
     will have `emoji-heart` as `keyboardImageName`.
     
     The `localizationKey` prefix and suffix are used to map
     each `imageName` to a localization key, which will then
     be used to get translated `description`s for each image,
     which for instance can be used for accessibility labels.
     
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
