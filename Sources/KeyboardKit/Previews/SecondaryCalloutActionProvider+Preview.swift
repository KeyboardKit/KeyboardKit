//
//  SecondaryCalloutActionProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension SecondaryCalloutActionProvider where Self == PreviewSecondaryCalloutActionProvider {
    
    /**
     This action provider can be used in SwiftUI previews.
     */
    static var preview: SecondaryCalloutActionProvider { PreviewSecondaryCalloutActionProvider() }
}

/**
 This action provider can be used in SwiftUI previews.
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
