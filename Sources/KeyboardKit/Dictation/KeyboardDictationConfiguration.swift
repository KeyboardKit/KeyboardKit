//
//  KeyboardKeyboardDictationConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-27.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This config can be used with a ``KeyboardDictationService``.

 This configuration defines all parameters needed to perform
 a dictation operation that requires a keyboard extension to
 coordinate with its main app.
 */
public struct KeyboardDictationConfiguration: Codable, Equatable {

    /**
     Create a keyboard dictation configuration.

     - Parameters:
       - appGroupId: An app group that can be used to sync data between your keyboard and its main app.
       - appDeepLink: A deep link that can be used to open your app and start the dictation operation.
     */
    public init(
        appGroupId: String,
        appDeepLink: String
    ) {
        self.appGroupId = appGroupId
        self.appDeepLink = appDeepLink
    }

    /**
     An app group that can be used to sync data between your
     keyboard and its main app.
     */
    public let appGroupId: String

    /**
     A deep link that can be used to open your app and start
     the dictation operation.
     */
    public let appDeepLink: String
}
