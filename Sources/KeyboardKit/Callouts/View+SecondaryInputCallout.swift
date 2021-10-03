//
//  View+SecondaryInputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     This modifier can be applied to any view that should be
     able to present a secondary input callout.
     
     - Parameters:
       - context: The context to bind against.
       - style: The style to apply to the view.
     */
    func secondaryInputCallout(
        context: SecondaryInputCalloutContext,
        style: SecondaryInputCalloutStyle = .standard) -> some View {
        return ZStack {
            self
            SecondaryInputCallout(context: context, style: style)
        }.coordinateSpace(name: SecondaryInputCalloutContext.coordinateSpace)
    }
}
