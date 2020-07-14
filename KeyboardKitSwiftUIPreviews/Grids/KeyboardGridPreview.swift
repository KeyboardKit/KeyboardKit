//
//  KeyboardGridPreview.swift
//  KeyboardKitSwiftUIPreviews
//
//  Created by Daniel Saidi on 2020-06-16.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI
import SwiftUI

struct KeyboardGridPreview: View {
    
    private static let action = KeyboardAction.systemImage(description: "", keyboardImageName: "globe", imageName: "")
    
    private var actions: [KeyboardAction] { Self.actions }
    
    static var actions: [KeyboardAction] = [
        action, action, action, action, action, action,
        action, action, action, action, action, action,
        action, action, action, action, action, action,
        action, action, action, action, action, action,
        action, action, action, action, action, action,
        action, action, action
    ]
    
    var body: some View {
        KeyboardGrid(
            actions: actions,
            columns: 6,
            buttonBuilder: { KeyboardImageButton(action: $0)} )
    }
}

struct KeyboardGridPreview_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardGridPreview()
    }
}
