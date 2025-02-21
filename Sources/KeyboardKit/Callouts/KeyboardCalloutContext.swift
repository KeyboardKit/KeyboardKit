//
//  KeyboardCalloutContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-24.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Combine
import SwiftUI

/// This context has observable callout-related state and is
/// used for both input and action callouts.
///
/// KeyboardKit will create an instance of this context, and
/// inject into the environment, when you set up KeyboardKit
/// as shown in <doc:Getting-Started-Article>.
public class KeyboardCalloutContext: ObservableObject {

    /// Create a keyboard callout context.
    public init() {}


    /// The coordinate space to use for callout.
    public let coordinateSpace = "com.keyboardkit.coordinate.callout"


    /// The callout service to use, if any.
    public var calloutService: KeyboardCalloutService?
    
    /// The scale to apply if the items must be compressed.
    public var compressedWidthScale = 0.85
    
    /// The scale to apply to drag selection index changes.
    public var dragIndexScaleFactor = 0.8

    /// The last time an input was updated.
    public var lastInputUpdate = Date()

    /// The minimum input callout duration.
    public var minimumInputDuration: TimeInterval = 0.05

    /// The action handler to use when tapping actions.
    public var actionHandler: (KeyboardAction) -> Void = { _ in }


    /// The currently active button frame.
    @Published public private(set) var buttonFrame: CGRect = .zero

    /// The current input action, if any.
    @Published public private(set) var inputAction: KeyboardAction?

    /// The current secondary actions.
    @Published public private(set) var secondaryActions: [KeyboardAction] = []

    /// The current secondary action callout alignment.
    @Published public private(set) var secondaryActionsAlignment: HorizontalAlignment = .leading

    /// The current secondary action index.
    @Published public private(set) var secondaryActionsIndex: Int = -1
}

public extension KeyboardCalloutContext {

    var selectedSecondaryAction: KeyboardAction? {
        let index = secondaryActionsIndex
        return isSecondaryActionIndexValid(index) ? secondaryActions[index] : nil
    }

    @discardableResult
    func handleSelectedSecondaryAction() -> Bool {
        guard let action = selectedSecondaryAction else { return false }
        actionHandler(action)
        resetSecondaryActions()
        return true
    }

    /// Reset the input action. This will remove the callout.
    func resetInputAction() {
        inputAction = nil
    }

    /// Reset the context with a slight delay, since we want
    /// the callout to be visible for a short while, even if
    /// the user immediately releases the button.
    func resetInputActionWithDelay() {
        let delay = minimumInputDuration
        let date = Date()
        lastInputUpdate = date
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.lastInputUpdate > date { return }
            self.resetInputAction()
        }
    }

    /// Reset the context. This will dismiss the callout.
    func resetSecondaryActions() {
        secondaryActions = []
        secondaryActionsIndex = -1
    }

    /// Update the current input for a certain action.
    func updateInputAction(
        _ action: KeyboardAction?,
        in geo: GeometryProxy
    ) {
        if action?.inputCalloutText == nil { return }
        lastInputUpdate = Date()
        inputAction = action
        buttonFrame = geo.frame(in: .named(coordinateSpace))
    }

    /// Update the secondary actions for a certain action.
    func updateSecondaryActions(
        for action: KeyboardAction?,
        in geo: GeometryProxy,
        alignment: HorizontalAlignment? = nil
    ) {
        guard let action = action else { return resetSecondaryActions() }
        guard let actions = calloutService?.calloutActions(for: action) else { return }
        buttonFrame = geo.frame(in: .named(coordinateSpace))
        secondaryActionsAlignment = alignment ?? resolveSecondaryActionAlignment(for: geo)
        secondaryActions = isLeading ? actions : actions.reversed()
        secondaryActionsIndex = secondaryActionStartIndex
        guard !secondaryActions.isEmpty else { return }
        triggerSelectionChangeFeedback()
    }
    
    /// Update the secondary action selection with a drag gesture value.
    func updateSecondaryActionsSelection(with value: DragGesture.Value) {
        guard buttonFrame != .zero else { return }
        if shouldResetSecondaryActions(for: value.translation) { return resetSecondaryActions() }
        guard shouldUpdateSecondaryActionSelection(for: value.translation) else { return }
        let standardStyle = KeyboardCallout.CalloutStyle.standard
        let maxButtonSize = standardStyle.actionItemMaxSize
        let buttonSize = buttonFrame.size.limited(to: maxButtonSize)
        guard buttonSize.width > 1 else { return }
        let indexWidth = max(20, dragIndexScaleFactor * buttonSize.width)
        let offset = isLeading ? Int(value.location.x / indexWidth) : Int(abs(value.location.x - indexWidth) / indexWidth)
        let index = isLeading ? offset : secondaryActions.count - offset - 1
        let currentIndex = self.secondaryActionsIndex
        let newIndex = isSecondaryActionIndexValid(index) ? index : secondaryActionStartIndex
        if currentIndex != newIndex { triggerSelectionChangeFeedback() }
        self.secondaryActionsIndex = newIndex
    }
}

extension KeyboardCalloutContext {

    func triggerSelectionChangeFeedback() {
        calloutService?.triggerFeedbackForSelectionChange()
    }
}

private extension KeyboardCalloutContext {

    var isLeading: Bool {
        secondaryActionsAlignment == .leading
    }

    var secondaryActionStartIndex: Int {
        isLeading ? 0 : secondaryActions.count - 1
    }

    func isSecondaryActionIndexValid(
        _ index: Int
    ) -> Bool {
        index >= 0 && index < secondaryActions.count
    }

    func resolveSecondaryActionAlignment(
        for geo: GeometryProxy
    ) -> HorizontalAlignment {
        #if os(iOS)
        let center = UIScreen.main.bounds.size.width / 2
        let isTrailing = buttonFrame.origin.x > center
        return isTrailing ? .trailing : .leading
        #else
        return .leading
        #endif
    }

    func shouldResetSecondaryActions(
        for dragTranslation: CGSize
    ) -> Bool {
        dragTranslation.height > buttonFrame.height
    }

    func shouldUpdateSecondaryActionSelection(
        for dragTranslation: CGSize
    ) -> Bool {
        let translation = dragTranslation.width
        if translation == 0 { return true }
        return isLeading ? translation > 0 : translation < 0
    }
}
