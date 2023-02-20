//
//  NextKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI
import UIKit

/**
 This button makes any view behave as a next keyboard button,
 which switches to the next keyboard when tapped and opens a
 keyboard switcher menu when pressed.

 Note that you must provide a `UIInputViewController` in the
 initializer or set ``NextKeyboardController/shared`` before
 you create an instance of this view. When using KeyboardKit,
 ``KeyboardInputViewController`` is automatically set to the
 shared instance in `viewDidLoad`.
 */
public struct NextKeyboardButton<Content: View>: View {

    public init(
        controller: UIInputViewController? = NextKeyboardController.shared,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.overlay = NextKeyboardButtonOverlay(controller: controller)
        self.content = content
    }

    private let content: () -> Content
    private let overlay: NextKeyboardButtonOverlay

    public var body: some View {
        content().overlay(overlay)
    }
}

struct NextKeyboardButton_Previews: PreviewProvider {
    
    static var previews: some View {
        NextKeyboardButton {
            Image.keyboardGlobe.font(.title)
        }
    }
}

/**
 This overlay sets up a `next keyboard` controller action on
 a blank `UIKit` button. This can hopefully be removed later,
 without public changes.
 */
private struct NextKeyboardButtonOverlay: UIViewRepresentable {

    init(controller: UIInputViewController?) {
        button = UIButton()
        if controller == nil && !ProcessInfo.isSwiftUIPreview { assertionFailure("Input view controller is nil") }
        controller?.setupNextKeyboardButton(button)
    }
    
    let button: UIButton
    
    func makeUIView(context: Context) -> UIButton { button }

    func updateUIView(_ uiView: UIButton, context: Context) {}
}

private extension UIInputViewController {

    func setupNextKeyboardButton(_ button: UIButton) {
        let action = #selector(handleInputModeList(from:with:))
        button.addTarget(self, action: action, for: .allTouchEvents)
    }
}

private extension ProcessInfo {

    var isSwiftUIPreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    static var isSwiftUIPreview: Bool {
        processInfo.isSwiftUIPreview
    }
}
#endif
