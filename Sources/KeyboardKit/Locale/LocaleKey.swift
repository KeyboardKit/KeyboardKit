//
//  LocaleKey.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum gathers locale identifiers so that we do not have
 to repeat ourselves when working with locale-based features. 
 */
public enum LocaleKey: String {
    
    case english = "en"
    case german = "de"
    case italian = "it"
    case swedish = "sv"
    
    public var key: String { rawValue }
}
