//
//  SubmitLabel+CaseIterable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-12-22.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension SubmitLabel {
    
    static var allCases: [SubmitLabel] {
        [.continue, .done, .go, .join, .next, .return, .route, .search, .send]
    }
}
