//
//  NextKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button makes any view behave as a next keyboard button,
 which switches to the next keyboard when tapped and opens a
 keyboard switcher menu when pressed.

 Note that this modifier only has effect on `iOS` and `tvOS`,
 since it requires an input view controller.
 */
public struct NextKeyboardButton<Content: View>: View {

    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }

    private let content: () -> Content

    public var body: some View {
        content().overlay(nextKeyboardButtonOverlay)
    }
}

struct NextKeyboardButton_Previews: PreviewProvider {
    
    static var previews: some View {
        NextKeyboardButton {
            Image.keyboardGlobe.font(.title)
        }
    }
}

private extension View {

    @ViewBuilder
    var nextKeyboardButtonOverlay: some View {
        #if os(iOS) || os(tvOS)
        NextKeyboardButtonOverlay()
        #else
        EmptyView()
        #endif
    }
}

#if os(iOS) || os(tvOS)
import UIKit

/**
 This overlay sets up a `next keyboard` controller action on
 a blank `UIKit` button. This can hopefully be removed later,
 without public changes.
 */
private struct NextKeyboardButtonOverlay: UIViewRepresentable {

    init(controller: KeyboardInputViewController = .shared) {
        button = UIButton()
        controller.setupNextKeyboardButton(button)
    }
    
    let button: UIButton
    
    func makeUIView(context: Context) -> UIButton { button }

    func updateUIView(_ uiView: UIButton, context: Context) {}
}

private extension UIInputViewController {
    
    /**
     Setup any `UIButton` as a "next keyboard" system button.
     */
    func setupNextKeyboardButton(_ button: UIButton) {
        let action = #selector(handleInputModeList(from:with:))
        button.addTarget(self, action: action, for: .allTouchEvents)
    }
}
#endif
