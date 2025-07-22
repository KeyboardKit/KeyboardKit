//
//  View+KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-21.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    typealias KeyboardGestureAction = () -> Void
    typealias KeyboardDragGestureAction = (_ startLocation: CGPoint, _ location: CGPoint) -> Void

    /// Apply keyboard button gestures that use the provided
    /// `actionHandler` to trigger gesture actions.
    ///
    /// The ``KeyboardAction/nextKeyboard`` action type will
    /// trigger system events instead of this action handler.
    ///
    /// - Parameters:
    ///   - action: The keyboard action to trigger.
    ///   - actionHandler: The keyboard action handler to use.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - calloutContext: The callout context to affect, if any.
    ///   - isPressed: An optional binding that can be used to observe the button pressed state.
    ///   - isGestureAutoCancellable: Whether an aborted gesture will auto-cancel itself, by default `false`.
    ///   - scrollState: The scroll state to use, if any.
    ///   - releaseOutsideTolerance: A custom percentage of the button size outside its bounds to count as a release, if any.
    func keyboardButtonGestures(
        for action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        calloutContext: CalloutContext?,
        isPressed: Binding<Bool> = .constant(false),
        isGestureAutoCancellable: Bool? = nil,
        scrollState: GestureButtonScrollState? = nil,
        releaseOutsideTolerance: Double = 1
    ) -> some View {
        self.keyboardButtonGestures(
            action: action,
            repeatTimer: repeatTimer,
            calloutContext: calloutContext,
            isPressed: isPressed,
            isGestureAutoCancellable: isGestureAutoCancellable,
            scrollState: scrollState,
            releaseOutsideTolerance: releaseOutsideTolerance,
            doubleTapAction: { actionHandler.handle(.doubleTap, on: action) },
            longPressAction: { actionHandler.handle(.longPress, on: action) },
            pressAction: { actionHandler.handle(.press, on: action) },
            releaseAction: { actionHandler.handle(.release, on: action) },
            repeatAction: { actionHandler.handle(.repeatPress, on: action) },
            dragAction: { start, current in actionHandler.handleDrag(on: action, from: start, to: current) },
            endAction: { actionHandler.handle(.end, on: action) }
        )
    }

    /// Apply keyboard button gestures that will trigger the
    /// provided actions.
    ///
    /// The ``KeyboardAction/nextKeyboard`` action type will
    /// trigger system events instead of these actions.
    ///
    /// - Parameters:
    ///   - action: The keyboard action to trigger, if any.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - calloutContext: The callout context to affect, if any.
    ///   - isPressed: An optional binding that can be used to observe the button pressed state, if any.
    ///   - isGestureAutoCancellable: Whether an aborted gesture will auto-cancel itself, by default `false`.
    ///   - scrollState: The scroll state to use, if any.
    ///   - releaseOutsideTolerance: A custom percentage of the button size outside its bounds to count as a release, if any.
    ///   - doubleTapAction: The action to trigger when the button is double tapped, if any.
    ///   - longPressAction: The action to trigger when the button is long pressed, if any.
    ///   - pressAction: The action to trigger when the button is pressed, if any.
    ///   - releaseAction: The action to trigger when the button is released, regardless of where the gesture ends, if any.
    ///   - repeatAction: The action to trigger when the button is pressed and held, if any.
    ///   - dragAction: The action to trigger when the button is dragged, if any.
    ///   - endAction: The action to trigger when the button gesture ends.
    @ViewBuilder
    func keyboardButtonGestures(
        action: KeyboardAction? = nil,
        repeatTimer: GestureButtonTimer? = nil,
        calloutContext: CalloutContext? = nil,
        isPressed: Binding<Bool> = .constant(false),
        isGestureAutoCancellable: Bool? = nil,
        scrollState: GestureButtonScrollState? = nil,
        releaseOutsideTolerance: Double? = nil,
        doubleTapAction: KeyboardGestureAction? = nil,
        longPressAction: KeyboardGestureAction? = nil,
        pressAction: KeyboardGestureAction? = nil,
        releaseAction: KeyboardGestureAction? = nil,
        repeatAction: KeyboardGestureAction? = nil,
        dragAction: KeyboardDragGestureAction? = nil,
        endAction: KeyboardGestureAction? = nil
    ) -> some View {
        #if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
        let gestures = Keyboard.ButtonGestures(
            view: self,
            action: action,
            repeatTimer: repeatTimer,
            calloutContext: calloutContext,
            isPressed: isPressed,
            isGestureAutoCancellable: isGestureAutoCancellable,
            scrollState: scrollState,
            releaseOutsideTolerance: releaseOutsideTolerance,
            doubleTapAction: doubleTapAction,
            longPressAction: longPressAction,
            pressAction: pressAction,
            releaseAction: releaseAction,
            repeatAction: repeatAction,
            dragAction: dragAction,
            endAction: endAction
        )
        #endif

        #if os(iOS) || os(visionOS)
        switch action {
        case .nextKeyboard:
            Keyboard.NextKeyboardButton {
                self
            }
        default:
            gestures
        }
        #elseif os(macOS) || os(watchOS)
        gestures
        #else
        Button {
            pressAction?()
            releaseAction?()
        } label: {
            self
        }
        #endif
    }
}

private extension Locale {
    var localizedAndCapitalized: String {
        let text = localizedString(forIdentifier: identifier) ?? "-"
        return text.capitalized
    }
}

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
import SwiftUI

extension Keyboard {

    /// This view applies keyboard gestures to any view.
    struct ButtonGestures<Content: View>: View {

        /// Apply a set of action gestures to a view.
        ///
        /// - Parameters:
        ///   - view: The view to apply the gestures to.
        ///   - action: The keyboard action to trigger.
        ///   - repeatTimer: The repeat gesture timer to use, if any.
        ///   - calloutContext: The callout context to affect, if any.
        ///   - isPressed: An optional binding that can be used to observe the button pressed state.
        ///   - isGestureAutoCancellable: Whether an aborted gesture will auto-cancel itself, by default `false`.
        ///   - scrollState: The scroll state to use, if any.
        ///   - releaseOutsideTolerance: The percentage of the button size outside its bounds that should count as a release, by default `1.0`.
        ///   - doubleTapAction: The action to trigger when the button is double tapped.
        ///   - longPressAction: The action to trigger when the button is long pressed.
        ///   - pressAction: The action to trigger when the button is pressed.
        ///   - releaseAction: The action to trigger when the button is released, regardless of where the gesture ends.
        ///   - repeatAction: The action to trigger when the button is pressed and held.
        ///   - dragAction: The action to trigger when the button is dragged.
        ///   - endAction: The action to trigger when the gesture end.
        init(
            view: Content,
            action: KeyboardAction?,
            repeatTimer: GestureButtonTimer?,
            calloutContext: CalloutContext?,
            isPressed: Binding<Bool>,
            isGestureAutoCancellable: Bool? = nil,
            scrollState: GestureButtonScrollState?,
            releaseOutsideTolerance: Double? = nil,
            doubleTapAction: KeyboardGestureAction?,
            longPressAction: KeyboardGestureAction?,
            pressAction: KeyboardGestureAction?,
            releaseAction: KeyboardGestureAction?,
            repeatAction: KeyboardGestureAction?,
            dragAction: KeyboardDragGestureAction?,
            endAction: KeyboardGestureAction?
        ) {
            self.view = view
            self.action = action
            self.repeatTimer = repeatTimer
            self.calloutContext = calloutContext
            self.isPressed = isPressed
            self.scrollState = scrollState
            self.releaseOutsideTolerance = releaseOutsideTolerance ?? 1.0
            self.cancelDelay = (isGestureAutoCancellable ?? false) ? 3 : nil
            self.doubleTapAction = doubleTapAction
            self.longPressAction = longPressAction
            self.pressAction = pressAction
            self.releaseAction = releaseAction
            self.repeatAction = repeatAction
            self.dragAction = dragAction
            self.endAction = endAction
        }

        private let view: Content
        private let action: KeyboardAction?
        private let repeatTimer: GestureButtonTimer?
        private let calloutContext: CalloutContext?
        private let isPressed: Binding<Bool>
        private let scrollState: GestureButtonScrollState?
        private let releaseOutsideTolerance: Double
        private let cancelDelay: Double?
        private let doubleTapAction: KeyboardGestureAction?
        private let longPressAction: KeyboardGestureAction?
        private let pressAction: KeyboardGestureAction?
        private let releaseAction: KeyboardGestureAction?
        private let repeatAction: KeyboardGestureAction?
        private let dragAction: KeyboardDragGestureAction?
        private let endAction: KeyboardGestureAction?

        @SwiftUI.State private var lastDragValue: DragGesture.Value?

        @Environment(\.gestureButtonConfiguration) private var configuration
        @Environment(\.keyboardCalloutActionsBuilder) private var calloutActionsBuilder

        @EnvironmentObject private var keyboardContext: KeyboardContext

        private var cancelConfig: GestureButtonConfiguration? {
            guard let cancelDelay else { return nil }
            var config = configuration
            config.cancelDelay = cancelDelay
            return config
        }

        var body: some View {
            view.overlay(geometryOverlay)
        }
        
        @ViewBuilder
        var geometryOverlay: some View {
            if let cancelConfig {
                geometryReader.keyboardButtonGestureConfiguration(cancelConfig)
            } else {
                geometryReader
            }
        }
        
        var geometryReader: some View {
            GeometryReader { geo in
                GestureButton(
                    isPressed: isPressed,
                    scrollState: scrollState,
                    pressAction: { handlePress(in: geo) },
                    releaseInsideAction: { handleReleaseInside(in: geo) },
                    releaseOutsideAction: { handleReleaseOutside(in: geo) },
                    longPressAction: { handleLongPress(in: geo) },
                    doubleTapAction: { handleDoubleTap(in: geo) },
                    repeatTimer: repeatTimer,
                    repeatAction: { handleRepeat(in: geo) },
                    dragAction: { handleDrag(in: geo, value: $0) },
                    endAction: { handleGestureEnded(in: geo) },
                    label: { _ in Color.clearInteractable }
                )
            }
        }
    }
}

private extension View {

    @ViewBuilder
    func optionalGesture<GestureType: Gesture>(_ gesture: GestureType?) -> some View {
        if let gesture = gesture {
            self.gesture(gesture)
        } else {
            self
        }
    }
}


// MARK: - Actions

private extension Keyboard.ButtonGestures {

    func handleDoubleTap(in geo: GeometryProxy) {
        doubleTapAction?()
    }

    func handleDrag(in geo: GeometryProxy, value: DragGesture.Value) {
        lastDragValue = value
        updateCalloutActionSelection(for: value)
        dragAction?(value.startLocation, value.location)
    }

    func handleGestureEnded(in geo: GeometryProxy) {
        calloutContext?.resetInputActionWithDelay()
        resetCalloutActions()
        resetGestureState()
        endAction?()
    }

    func handleLongPress(in geo: GeometryProxy) {
        activateActionCallout(in: geo)
        longPressAction?()
    }

    func handlePress(in geo: GeometryProxy) {
        pressAction?()
        calloutContext?.updateInputAction(action, in: geo)
    }

    func handleReleaseInside(in geo: GeometryProxy) {
        if handleCalloutAction() { return }
        releaseAction?()
    }

    func handleReleaseOutside(in geo: GeometryProxy) {
        if handleCalloutAction() { return }
        guard shouldApplyReleaseOutsize(for: geo) else { return }
        handleReleaseInside(in: geo)
    }

    func handleRepeat(in geo: GeometryProxy) {
        repeatAction?()
    }

    func resetGestureState() {
        lastDragValue = nil
    }

    func shouldApplyReleaseOutsize(for geo: GeometryProxy) -> Bool {
        guard let dragValue = lastDragValue else { return false }
        let rect = CGRect.releaseOutsideToleranceArea(for: geo, tolerance: releaseOutsideTolerance)
        let isInsideTolerance = rect.contains(dragValue.location)
        return isInsideTolerance
    }
}


// MARK: - Callouts

private extension Keyboard.ButtonGestures {

    func activateActionCallout(in geo: GeometryProxy) {
        guard let context = calloutContext else { return }
        updateCalloutActions(in: geo)
        if context.secondaryActions.isEmpty { return }
        context.resetInputAction()
    }

    func handleCalloutAction() -> Bool {
        guard let context = calloutContext else { return false }
        return context.handleSelectedSecondaryAction()
    }

    func resetCalloutActions() {
        calloutContext?.resetSecondaryActions()
    }

    func updateCalloutActions(
        in geo: GeometryProxy
    ) {
        guard let context = calloutContext else { return }
        guard let action else { return resetCalloutActions() }
        let params = Callouts.ActionsBuilderParams(action: action)
        let actions = calloutActionsBuilder(params)
        context.updateSecondaryActions(actions, for: action, in: geo)
    }

    func updateCalloutActionSelection(
        for value: DragGesture.Value
    ) {
        guard let context = calloutContext else { return }
        context.updateSecondaryActionsSelection(with: value)
    }
}

extension CGRect {

    /// Return a rect with release outside tolerance padding.
    static func releaseOutsideToleranceArea(
        for geo: GeometryProxy,
        tolerance: Double
    ) -> CGRect {
        let size = geo.size
        let rect = CGRect(origin: .zero, size: geo.size)
            .insetBy(dx: -size.width * tolerance, dy: -size.height * tolerance)
        return rect
    }
}
#endif
