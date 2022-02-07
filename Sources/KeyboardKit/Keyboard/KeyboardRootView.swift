//
//  KeyboardRootView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view is used as a wrapper view, to be able to bind
 the keyboard view to properties that affect your layout
 without triggering a view update.
 */
struct KeyboardRootView<ViewType: View>: View {
    
    init(_ view: ViewType) {
        self.view = view
    }
    
    var view: ViewType
    
    @EnvironmentObject private var context: KeyboardContext
    
    var body: some View {
        view.id(bodyId)
    }
    
    var bodyId: String {
        #if os(iOS)
        "\(context.locale)\(context.colorScheme)\(context.screenOrientation.isLandscape)"
        #elseif os(tvOS)
        "\(context.locale)\(context.colorScheme)"
        #else
        "\(context.locale)"
        #endif
    }
}
