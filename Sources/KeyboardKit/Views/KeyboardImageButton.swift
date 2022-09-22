//
//  KeyboardImageButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button shows an image with a tap and long press action.
 */
public struct KeyboardImageButton: View {
    
    /**
     Create a keyboard image button that uses the `image` of
     the provided `KeyboardAction`, if it has one.
     */
    public init(
        action: KeyboardAction,
        tapAction: @escaping () -> Void = {},
        longPressAction: @escaping () -> Void = {}
    ) {
        self.image = action.image
        self.tapAction = tapAction
        self.longPressAction = longPressAction
    }
    
    /**
     Create a keyboard image button with a custom `Image`.
     */
    public init(
        image: Image,
        tapAction: @escaping () -> Void = {},
        longPressAction: @escaping () -> Void = {}
    ) {
        self.image = image
        self.tapAction = tapAction
        self.longPressAction = longPressAction
    }
    
    private let image: Image
    private let tapAction: () -> Void
    private let longPressAction: () -> Void
    
    public var body: some View {
        image
            .resizable()
            .scaledToFit()
            .accessibility(addTraits: .isButton)
            #if os(iOS) || os(macOS) || os(watchOS)
            .onTapGesture(perform: tapAction)
            .onLongPressGesture(perform: longPressAction)
            #endif
    }
}

private extension KeyboardAction {
    
    var image: Image {
        switch self {
        case .image(_, let imageName, _): return Image(imageName, bundle: .keyboardKit)
        case .systemImage(_, let imageName, _): return Image(systemName: imageName)
        default: return Image("")
        }
    }
}

struct KeyboardImageButton_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            KeyboardImageButton(action: .image(description: "", keyboardImageName: "iPhone12_sv_alphabetic_portrait_lowercase", imageName: ""))
            KeyboardImageButton(action: .systemImage(description: "", keyboardImageName: "checkmark", imageName: ""))
        }
    }
}
