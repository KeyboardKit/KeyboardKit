//
//  Keyboard+NextKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import SwiftUI
import UIKit

public extension Keyboard {

    /// This view makes any view behave as a native keyboard
    /// switcher button, which switches to the next keyboard
    /// when tapped, and opens a switcher menu on long press.
    ///
    /// Use ``NextKeyboardButtonControllerMode`` to define a
    /// controller mode to run in. The classic mode requires
    /// us to pass in a `UIInputViewController`, or fallback
    /// to the ``NextKeyboardController/shared``, which will
    /// be removed in KeyboardKit 9. Both experimental modes
    /// let us triggering the switcher action without having
    /// to pass in a controller.
    ///
    /// Use ``NextKeyboardButtonProxyMode`` to define how to
    /// handle any active text input proxy. The classic mode
    /// doesn't do anything, which causes an active proxy to
    /// stop the input switcher action from working. Use the
    /// experimental mode to automatically disable an active
    /// proxy for the duration of the switcher gesture. This
    /// makes the input switcher work, after which the proxy
    /// is restored.
    ///
    /// If this experimental mode proves successful, it will
    /// replace the classic mode in KeyboardKit 9.
    struct NextKeyboardButton<Content: View>: View {

        public init(
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.overlay = NextKeyboardButtonOverlay()
            self.content = content
        }

        private let content: () -> Content
        private let overlay: NextKeyboardButtonOverlay

        public var body: some View {
            content()
                .overlay(overlay)
        }
    }
}

#Preview {

    Keyboard.NextKeyboardButton {
        Image.keyboardGlobe.font(.title)
    }
}

/// This overlay sets up a `next keyboard` controller action
/// on a blank `UIKit` button. This can hopefully be removed
/// later, without public changes.
private struct NextKeyboardButtonOverlay: UIViewRepresentable {

    init() {
        button = UIButton()
    }

    let button: UIButton

    func makeUIView(context: Context) -> UIButton {
        setupButtonTarget()
        return button
    }

    func updateUIView(_ uiView: UIButton, context: Context) {}

    func setupButtonTarget() {
        if ProcessInfo.isSwiftUIPreview { return }
        UIInputViewController().setupButton(button)
    }
}

private extension UIInputViewController {


    func setupButton(_ button: UIButton) {
        let proxyAction = #selector(handleInputProxy(from:with:))
        let inputAction = #selector(handleInputModeList(from:with:))
        button.addTarget(nil, action: proxyAction, for: .allTouchEvents)
        button.addTarget(nil, action: inputAction, for: .allTouchEvents)
    }

    @objc func handleInputProxy(from view: UIView, with event: UIEvent) {
        guard let vc = self as? KeyboardInputViewController else { return }
        if vc.textInputProxy == nil { return }
        let input = vc.textInputProxy
        vc.textInputProxy = nil
        handleInputModeList(from: view, with: event)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            vc.textInputProxy = input
        }
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
