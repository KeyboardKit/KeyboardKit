//
//  Autocomplete+Suggestion.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-12.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {
 
    /**
     This struct represents a suggestion that is returned by
     an ``AutocompleteProvider``.
     
     `isAutocorrect` suggestions are usually rendered with a
     white background and are applied when a user taps space.
     
     `isUnknown` suggestions are usually rendered wrapped in
     locale-specific quotation marks.
     */
    struct Suggestion {
        
        /**
         Create an autocomplete suggestion.

         - Parameters:
           - text: The text that should be sent to the proxy.
           - title: The text that should be displayed, by default `text`.
           - isAutocorrect: Whether or not this is an autocorrect suggestion, by default `false`.
           - isUnknown: Whether or not this is an unknown suggestion, by default `false`.
           - subtitle: An optional subtitle that can complete the title, by default `nil`.
           - additionalInfo: An optional dictionary that can contain additional info, by default `empty`.
         */
        public init(
            text: String,
            title: String? = nil,
            isAutocorrect: Bool = false,
            isUnknown: Bool = false,
            subtitle: String? = nil,
            additionalInfo: [String: Any] = [:]
        ) {
            self.text = text
            self.title = title ?? text
            self.isAutocorrect = isAutocorrect
            self.isUnknown = isUnknown
            self.subtitle = subtitle
            self.additionalInfo = additionalInfo
        }
        
        /// The text that should be sent to the proxy.
        public var text: String
        
        /// The text that should be presented.
        public var title: String
        
        /// Whether or not this is an autocorrect suggestion.
        public var isAutocorrect: Bool
        
        /// Whether or not this is an unknown suggestion.
        public var isUnknown: Bool
        
        /// An optional subtitle that can complete the title.
        public var subtitle: String?
        
        /// An optional dictionary with additional info.
        public var additionalInfo: [String: Any]
    }
}
