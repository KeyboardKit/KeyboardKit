//
//  ImageKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI
import SwiftUI

/**
 This keyboard is a custom view that is implemented for this
 project alone. It implements the shared `DemoImageKeyboard`
 and lists its images in a grid, where the number of columns
 depend on if the grid is presented in portrait or landscape.
 */
struct ImageKeyboard: View, DemoImageKeyboard {
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var body: some View {
        KeyboardGrid(
            actions: actions,
            columns: isLandscape ? 8 : 6,
            spacing: 20,
            buttonBuilder: button)
    }
}

private extension ImageKeyboard {
    
    var isLandscape: Bool { context.controller.deviceOrientation.isLandscape }
    
    func button(for action: KeyboardAction) -> some View {
        KeyboardImageButton(action: action)
            .keyboardAction(action, context: context)
    }
}
