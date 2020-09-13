//
//  ImageKeyboard.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-09-13.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI
import SwiftUI

struct ImageKeyboard: View, DemoImageKeyboard {
    
    var body: some View {
        KeyboardGrid(
            actions: actions,
            columns: isLandscape ? 8 : 6,
            spacing: 20,
            buttonBuilder: button)
    }
    
    @EnvironmentObject var context: ObservableKeyboardContext
    
    var isLandscape: Bool { context.controller.deviceOrientation.isLandscape }
    
    func button(for action: KeyboardAction) -> some View {
        ZStack {
            KeyboardImageButton(action: action)
                .keyboardAction(action, context: context)
            Text(context.keyboardType.systemKeyboardButtonText ?? "-")
        }
    }
}
