//
//  CalloutActionProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardCalloutContext {

    /// This context can be used in SwiftUI previews.
    static var preview = KeyboardCalloutContext(
        action: .preview,
        input: .preview
    )
}

public extension KeyboardCalloutContext.ActionContext {

    /// This context can be used in SwiftUI previews.
    static var preview = KeyboardCalloutContext.ActionContext(
        actionHandler: .preview,
        actionProvider: .preview
    )
}

public extension KeyboardCalloutContext.InputContext {
    
    /// This context can be used in SwiftUI previews.
    static var preview = KeyboardCalloutContext.InputContext(
        isEnabled: true
    )
}

public extension CalloutActionProvider where Self == PreviewCalloutActionProvider {
    
    /// This provider can be used in SwiftUI previews.
    static var preview: CalloutActionProvider { PreviewCalloutActionProvider() }
}

/// This provider can be used in SwiftUI previews.
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
