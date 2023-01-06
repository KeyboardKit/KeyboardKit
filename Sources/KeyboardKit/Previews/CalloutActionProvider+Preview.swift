//
//  CalloutActionProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension CalloutActionProvider where Self == PreviewCalloutActionProvider {
    
    /**
     This preview provider can be used in SwiftUI previews.
     */
    static var preview: CalloutActionProvider { PreviewCalloutActionProvider() }
}

/**
 This action provider can be used in SwiftUI previews.
 */
public class PreviewCalloutActionProvider: CalloutActionProvider {
    
    public init(keyboardContext: KeyboardContext = .preview) {
        provider = StandardCalloutActionProvider(
            keyboardContext: keyboardContext
        )
    }
    
    private let provider: CalloutActionProvider
    
    public func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        provider.calloutActions(for: action)
    }
}
