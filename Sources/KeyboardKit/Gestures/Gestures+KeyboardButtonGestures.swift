//
//  Gestures+KeyboardButtonGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
import SwiftUI

extension Gestures {

    /// This view applies keyboard gestures to any view.
    struct KeyboardButtonGestures<Content: View>: View {

        /// Apply a set of action gestures to a view.
        ///
        /// - Parameters:
        ///   - view: The view to apply the gestures to.
        ///   - action: The keyboard action to trigger.
        ///   - repeatTimer: The repeat gesture timer to use, if any.
        ///   - calloutContext: The callout context to affect, if any.
        ///   - isPressed: An optional binding that can be used to observe the button pressed state.
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
            calloutContext: KeyboardCalloutContext?,
            isPressed: Binding<Bool>,
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
        private let calloutContext: KeyboardCalloutContext?
        private let isPressed: Binding<Bool>
        private let scrollState: GestureButtonScrollState?
        private let releaseOutsideTolerance: Double
        private let doubleTapAction: KeyboardGestureAction?
        private let longPressAction: KeyboardGestureAction?
        private let pressAction: KeyboardGestureAction?
        private let releaseAction: KeyboardGestureAction?
        private let repeatAction: KeyboardGestureAction?
        private let dragAction: KeyboardDragGestureAction?
        private let endAction: KeyboardGestureAction?

        @State
        private var lastDragValue: DragGesture.Value?

        var body: some View {
            view.overlay(
                GeometryReader { geo in
                    button(for: geo)
                }
            )
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

// MARK: - Views

private extension Gestures.KeyboardButtonGestures {

    func button(for geo: GeometryProxy) -> some View {
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


// MARK: - Actions

private extension Gestures.KeyboardButtonGestures {

    func handleDoubleTap(in geo: GeometryProxy) {
        doubleTapAction?()
    }

    func handleDrag(in geo: GeometryProxy, value: DragGesture.Value) {
        lastDragValue = value
        calloutContext?.updateSecondaryActionsSelection(with: value.translation)
        dragAction?(value.startLocation, value.location)
    }

    func handleGestureEnded(in geo: GeometryProxy) {
        calloutContext?.resetInputActionWithDelay()
        calloutContext?.resetSecondaryActions()
        resetGestureState()
        endAction?()
    }

    func handleLongPress(in geo: GeometryProxy) {
        tryBeginActionCallout(in: geo)
        longPressAction?()
    }

    func handlePress(in geo: GeometryProxy) {
        pressAction?()
        calloutContext?.updateInputAction(action, in: geo)
    }

    func handleReleaseInside(in geo: GeometryProxy) {
        if tryHandleCalloutAction() { return }
        releaseAction?()
    }

    func handleReleaseOutside(in geo: GeometryProxy) {
        if tryHandleCalloutAction() { return }
        guard shouldApplyReleaseOutsize(for: geo) else { return }
        handleReleaseInside(in: geo)
    }

    func handleRepeat(in geo: GeometryProxy) {
        repeatAction?()
    }

    func tryBeginActionCallout(in geo: GeometryProxy) {
        guard let context = calloutContext else { return }
        context.updateSecondaryActions(for: action, in: geo)
        guard !context.secondaryActions.isEmpty else { return }
        calloutContext?.resetInputAction()
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

    func tryHandleCalloutAction() -> Bool {
        guard let context = calloutContext else { return false }
        return context.handleSelectedSecondaryAction()
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
