//
//  Locale+Flag.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-27.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public extension Locale {

    /**
     Get the locale flag symbol that can be used as an emoji.

     This only works if the locale has a region identifier.
     */
    var flag: String? {
        let regionIdentifier = region?.identifier
        let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
        let flag = regionIdentifier?
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(flagBase + $0.value)?.description }
            .joined()
        return flag ?? ""
    }
}
