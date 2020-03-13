//
//  ImageButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button can be used for `.image` actions. It's a button
 that contains an image, and has a tap and long press action.
 
 If you need any other modifiers, like `accessibility`, more
 actions etc. you can add it to the button instance.
 */
@available(iOS 13.0, *)
public struct ImageKeyboardButton: View {
    
    public init(
        action: KeyboardAction,
        tapAction: @escaping () -> Void = {},
        longPressAction: @escaping () -> Void = {}) {
        self.action = action
        self.tapAction = tapAction
        self.longPressAction = longPressAction
    }
    
    private let action: KeyboardAction
    private let tapAction: () -> Void
    private let longPressAction: () -> Void
    
    public var body: some View {
        Button(action: tapAction) {
            Image(uiImage: action.image)
                .resizable()
                .scaledToFit()
                .onLongPressGesture(perform: longPressAction)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

@available(iOS 13.0, *)
private extension KeyboardAction {
    
    var image: UIImage {
        switch self {
        case .image(_, let imageName, _): return UIImage(named: imageName) ?? UIImage()
        default: return UIImage()
        }
    }
}
