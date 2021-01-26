//
//  EmojiCategory+Identifiable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension EmojiCategory: Identifiable {
    
    public var id: String { rawValue }
}
