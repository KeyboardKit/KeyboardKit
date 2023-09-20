//
//  CalloutContext+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension CalloutContext {

    /// This context can be used in SwiftUI previews.
    static var preview = CalloutContext(
        actionContext: .preview,
        inputContext: .preview
    )
}

public extension CalloutActionContext {

    /// This context can be used in SwiftUI previews.
    static var preview = CalloutActionContext(
        actionHandler: .preview,
        actionProvider: .preview
    )
}

public extension CalloutInputContext {
    
    /// This context can be used in SwiftUI previews.
    static var preview = CalloutInputContext(
        isEnabled: true
    )
}

public extension CalloutActionProvider where Self == PreviewCalloutActionProvider {
    
    /// This provider can be used in SwiftUI previews.
    static var preview: CalloutActionProvider { PreviewCalloutActionProvider() }
}

/// This provider can be used in SwiftUI previews.
public class PreviewCalloutActionProvider: BaseCalloutActionProvider {
    
    public override func calloutActionString(
        for char: String
    ) -> String {
        switch char {
        case "a": return "aåä"
        default: return ""
        }
    }
}
