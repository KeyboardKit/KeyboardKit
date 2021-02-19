//
//  SecondaryCalloutActionProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to preview keyboard views. Don't use
 it in other situations.
 */
public class PreviewSecondaryCalloutActionProvider: SecondaryCalloutActionProvider {
    
    public init(context: KeyboardContext = .preview) {
        provider = StandardSecondaryCalloutActionProvider(context: context)
    }
    
    private let provider: SecondaryCalloutActionProvider
    
    public func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        provider.secondaryCalloutActions(for: action)
    }
}
