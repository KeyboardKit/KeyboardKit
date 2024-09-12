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
    /// mode to run in. The classic mode requires us to pass
    /// in a `UIInputViewController` into the initializer or
    /// fallback to ``NextKeyboardController/shared``, while
    /// the experimental mode creates a controller for every
    /// new button, then uses that instance as action target.
    ///
    /// If this experimental mode proves successful, it will
    /// replace the classic mode in KeyboardKit 9.
    struct NextKeyboardButton<Content: View>: View {
        
        public init(
            controller: UIInputViewController? = nil,
            throwAssertionForMissingController: Bool = false,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.overlay = NextKeyboardButtonOverlay(
                controller: controller ?? Keyboard.NextKeyboardController.shared
                )
            self.content = content
            self.throwAssertionForMissingController = throwAssertionForMissingController
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
    enum NextKeyboardButtonControllerMode {

        /// We must pass in a controller or use the shared one.
        case classic

        /// The button will create its own controller instance.
        case experimental

        /// The button will use a nil selector action target.
        case experimentalNilTarget

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

    func setupButton(_ button: UIButton) {
        let action = #selector(handleInputModeList(from:with:))
        switch Keyboard.NextKeyboardButtonControllerMode.current {
        case .experimentalNilTarget: button.addTarget(nil, action: action, for: .allTouchEvents)
        default: button.addTarget(self, action: action, for: .allTouchEvents)
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
