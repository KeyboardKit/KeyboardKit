//
//  NextKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This button switches to the next keyboard when it is tapped
 and opens a keyboard switcher menu when it is pressed.
 */
public struct NextKeyboardButton: View {
    
    /**
     Create a new next keyboard button.
     
     - Parameters:
       - image: The image to use, default `.globe`.
       - controller: The controller to which the button should apply.
     */
    public init(
        image: Image = .keyboardGlobe,
        controller: KeyboardInputViewController = .shared
    ) {
        self.image = image
        self.button = NextKeyboardButtonOverlay(controller: controller)
    }
    
    private let image: Image
    private let button: NextKeyboardButtonOverlay
    
    public var body: some View {
        image
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(button)
    }
}

struct NextKeyboardButton_Previews: PreviewProvider {
    
    static var previews: some View {
        NextKeyboardButton()
            .font(.title)
    }
}


/**
 This overlay sets up a `next keyboard` controller action on
 a blank `UIKit` button. This can hopefully be removed later,
 without public changes.
 */
private struct NextKeyboardButtonOverlay: UIViewRepresentable {
    
    init(controller: KeyboardInputViewController) {
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
