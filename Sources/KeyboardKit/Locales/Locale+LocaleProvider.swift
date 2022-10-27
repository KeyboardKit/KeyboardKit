//
//  Locale+LocaleProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-27.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

extension Locale: LocaleProvider {}

public extension Locale {

    /**
     The locale uses itself as the flag provider locale.
     */
    var locale: Locale { self }
}
