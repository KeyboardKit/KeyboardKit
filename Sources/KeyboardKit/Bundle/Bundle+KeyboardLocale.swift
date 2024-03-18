//
//  Bundle+KeyboardLocale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-31.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension Bundle {
    
    func bundle(for locale: KeyboardLocale) -> Bundle? {
        bundle(for: locale.locale)
    }
}
