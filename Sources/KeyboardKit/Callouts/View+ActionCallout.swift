//
//  View+ActionCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     This modifier can be applied to any view that should be
     able to present a ``ActionCallout``.
     
     - Parameters:
       - context: The context to bind against.
       - style: The style to apply to the view, by default `.standard`.
     */
    func actionCallout(
        context: ActionCalloutContext,
        style: ActionCalloutStyle = .standard) -> some View {
        return ZStack {
            self
            SecondaryInputCallout(context: context, style: style)
        }.coordinateSpace(name: ActionCalloutContext.coordinateSpace)
    }
}
