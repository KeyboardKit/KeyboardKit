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
            controller: UIInputViewController? = nil,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.overlay = NextKeyboardButtonOverlay(
                controller: controller ?? Keyboard.NextKeyboardController.shared
                )
            self.content = content
            self.throwAssertionForMissingController = false
        }

        @available(*, deprecated, message: "throwAssertionForMissingController is no longer used. Use the other initializer.")
        public init(
            controller: UIInputViewController? = nil,
            throwAssertionForMissingController: Bool,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.init(controller: controller, content: content)
        }

        private let content: () -> Content
        private let overlay: NextKeyboardButtonOverlay
        private let throwAssertionForMissingController: Bool

        public var body: some View {
            content()
                .overlay(overlay)
        }
    }
}

public extension Keyboard {

    /// This TEMPORARY mode can be used to test a new way to
    /// create a ``NextKeyboardButton`` without a controller.
    ///
    /// Set ``current`` to ``classic`` for the standard mode
    /// that requires us to provide a controller, or use the
    /// ``Keyboard/NextKeyboardController/shared`` instance.
    ///
    /// Set ``current`` to ``experimental`` to configure the
    /// ``NextKeyboardButton`` to create a controller itself.
    ///
    /// Set ``current`` to ``experimentalNilTarget`` to make
    /// the ``NextKeyboardButton`` use a `nil` action target.
    /// If this works, we do not need a controller reference,
    /// which would be absolutely amazing.
    ///
    /// The reason for trying the experimental modes is that
    /// the ``NextKeyboardButton`` randomly stops working in
    /// some cases, then doesn't trigger the switcher action.
    /// The only way this can happen, is that the controller
    /// reference becomes `nil`. My hope is that by creating
    /// a strong controller reference within the button, the
    /// controller will never be deallocated.
    ///
    /// If the experimental mode work, we don't have to keep
    /// a reference to the current controller. This would be
    /// amazing since we can deprecate the shared controller.
    enum NextKeyboardButtonControllerMode: Equatable {

        /// We must provide a controller or use a shared one.
        case classic

        /// The button will create a new controller instance.
        case experimental

        /// The button will use a nil selector action target.
        case experimentalNilTarget

        /// The next keyboard button controller mode to use.
        public static var current = Self.classic
    }

    /// This TEMPORARY mode can be used to test a new way to
    /// make the ``NextKeyboardButton`` work when text input
    /// is being made inside the keyboard extension, using a
    /// ``KeyboardInputViewController/textInputProxy``.
    ///
    /// Set ``current`` to ``classic`` for the standard mode,
    /// where the button is disabled while a proxy is active.
    ///
    /// Set ``current`` to ``experimental`` to configure the
    /// ``NextKeyboardButton`` to temp reset the proxy. This
    /// seems to allow the keyboard switcher to be presented.
    enum NextKeyboardButtonProxyMode: Equatable {

        /// The button will not affect a current input proxy.
        case classic

        /// The button will temp reset a current input proxy.
        case experimental

        /// The next keyboard button controller mode to use.
        public static var current = Self.classic
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

    init(
        controller: UIInputViewController?
    ) {
        switch Keyboard.NextKeyboardButtonControllerMode.current {
        case .classic: self.controller = controller
        case .experimental: experimentalController = .init()
        case .experimentalNilTarget: break
        }
        button = UIButton()
    }

    unowned var controller: UIInputViewController!
    var experimentalController: UIInputViewController!
    let button: UIButton

    func makeUIView(context: Context) -> UIButton {
        setupButtonTarget()
        return button
    }

    func updateUIView(_ uiView: UIButton, context: Context) {}

    func setupButtonTarget() {
        if ProcessInfo.isSwiftUIPreview { return }
        switch Keyboard.NextKeyboardButtonControllerMode.current {
        case .classic: controller.setupButton(button)
        case .experimental: experimentalController.setupButton(button)
        case .experimentalNilTarget: UIInputViewController().setupButton(button)
        }
    }
}

private extension UIInputViewController {

    var shouldApplyProxyAction: Bool {
        Keyboard.NextKeyboardButtonProxyMode.current == .experimental
    }

    func setupButton(_ button: UIButton) {
        let proxyAction = #selector(handleInputProxy(from:with:))
        let inputAction = #selector(handleInputModeList(from:with:))
        switch Keyboard.NextKeyboardButtonControllerMode.current {
        case .experimentalNilTarget:
            if shouldApplyProxyAction {
                button.addTarget(nil, action: proxyAction, for: .allTouchEvents)
            }
            button.addTarget(nil, action: inputAction, for: .allTouchEvents)
        default:
            if shouldApplyProxyAction {
                button.addTarget(self, action: proxyAction, for: .allTouchEvents)
            }
            button.addTarget(self, action: inputAction, for: .allTouchEvents)
        }
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
