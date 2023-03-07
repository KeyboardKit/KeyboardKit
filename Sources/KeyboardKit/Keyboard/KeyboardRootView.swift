//
//  KeyboardRootView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view is used as a wrapper view, to be able to bind the
 keyboard view to properties that affect your layout without
 triggering a view update.
 */
struct KeyboardRootView<ViewType: View>: View {
    
    init(@ViewBuilder _ view: @escaping () -> ViewType) {
        self.view = view
    }
    
    var view: () -> ViewType

    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var calloutContext: KeyboardCalloutContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    
    var body: some View {
        view()
    }
}
