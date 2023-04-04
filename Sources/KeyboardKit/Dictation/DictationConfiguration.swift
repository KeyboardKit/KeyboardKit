//
//  DictationConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-27.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This config can be used with a ``DictationService``.

 This configuration defines all parameters needed to perform
 a standard dictation operation.
 */
public struct DictationConfiguration: Codable, Equatable {

    /**
     Create a dictation configuration.

     - Parameters:
       - localeId: The locale to use for dictation, by default the ID of the `.current` locale.
     */
    public init(
        localeId: String = Locale.current.identifier
    ) {
        self.localeId = localeId
    }

    // The locale to use for dictation.
    public let localeId: String
}

public extension DictationConfiguration {

    /**
     Get a standard configuration for the current locale.
     */
    static var standard: DictationConfiguration {
        DictationConfiguration()
    }
}
