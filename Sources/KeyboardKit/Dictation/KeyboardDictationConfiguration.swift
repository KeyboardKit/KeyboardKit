//
//  Dictation+KeyboardConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-27.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Dictation {
    
    /**
     This can be used with a ``KeyboardDictationService``.
     
     This configuration defines parameters needed to perform
     dictation that requires a keyboard extension to sync an
     operation with its main app.
     */
    struct KeyboardConfiguration: Codable, Equatable {
        
        /**
         Create a keyboard dictation configuration.
         
         - Parameters:
           - appGroupId: The app group to use to sync data between the keyboard and the app.
           - appDeepLink: The deep link to use to open the app and start the dictation.
         */
        public init(
            appGroupId: String,
            appDeepLink: String
        ) {
            self.appGroupId = appGroupId
            self.appDeepLink = appDeepLink
        }
        
        /// The app group to use to sync data.
        public let appGroupId: String
        
        /// The deep link to use to open the app.
        public let appDeepLink: String
    }
}

public extension Dictation.KeyboardConfiguration {

    /// Whether or not the ``appDeepLink`` matches the url.
    func matchesDeepLink(_ url: URL) -> Bool {
        url.absoluteString == appDeepLink
    }
}
