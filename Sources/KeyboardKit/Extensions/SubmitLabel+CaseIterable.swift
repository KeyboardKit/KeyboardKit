//
//  SubmitLabel+CaseIterable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-12-22.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension SubmitLabel: @retroactive CaseIterable {}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension SubmitLabel {
    
    static var allCases: [SubmitLabel] {
        [.continue, .done, .go, .join, .next, .return, .route, .search, .send]
    }
}
