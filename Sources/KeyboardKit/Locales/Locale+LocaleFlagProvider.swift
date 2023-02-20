//
//  Locale+LocaleFlagProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-27.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

extension Locale: LocaleFlagProvider {}

public extension Locale {

    /**
     The locale's flag symbol.
     */
    var flag: String { standardFlag }
}
