//
//  ImageKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This keyboard is a custom view that is implemented for this
 project alone. It implements the shared `DemoImageKeyboard`
 and lists its images in a grid, where the number of columns
 depend on if the grid is presented in portrait or landscape.
 */
struct ImageKeyboard: View, DemoImageKeyboard {
    
    var actionHandler: KeyboardActionHandler
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    @EnvironmentObject private var inputCalloutContext: InputCalloutContext
    
    var body: some View {
        VStack(spacing: 30) {
            KeyboardGrid(
                actions: actions,
                columns: columns,
                spacing: 20,
                buttonBuilder: imageButton)
            bottomRow.frame(height: 40)
        }.frame(height: 300)
    }
}

private extension ImageKeyboard {
    
    var columns: Int { isLandscape ? 8 : 6 }
    
    var isLandscape: Bool { context.deviceOrientation.isLandscape }
    
    var bottomRow: some View {
        button(for: .nextKeyboard)
    }
    
    func button(for action: KeyboardAction) -> some View {
        SystemKeyboardButton(action: action, actionHandler: actionHandler)
    }
    
    func imageButton(for action: KeyboardAction) -> some View {
        KeyboardImageButton(action: action)
            .keyboardGestures(for: action, actionHandler: actionHandler, inputCalloutContext: inputCalloutContext)
    }
}
