//
//  KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS)
import SwiftUI

/**
 This view wraps any view and applies a ``GestureButton`` to
 it, to handle all actions for the provided keyboard action.
 
 This view is internal. Apply it with `View+keyboardGestures`.
 */
struct KeyboardGestures<Content: View>: View {
    
    /**
     Apply a set of optional gesture actions to the provided
     view, for a certain keyboard action.
     
     - Parameters:
       - view: The view to apply the gestures to.
       - action: The keyboard action to trigger.
       - calloutContext: The callout context to affect, if any.
       - isInScrollView: Whether or not the gestures are used in a scroll view.
       - isPressed: An optional binding that can be used to observe the button pressed state.
       - doubleTapAction: The action to trigger when the button is double tapped.
       - longPressAction: The action to trigger when the button is long pressed.
       - pressAction: The action to trigger when the button is pressed.
       - releaseAction: The action to trigger when the button is released, regardless of where the gesture ends.
       - repeatAction: The action to trigger when the button is pressed and held.
       - dragAction: The action to trigger when the button is dragged.
     */
    init(
        view: Content,
        action: KeyboardAction?,
        calloutContext: KeyboardCalloutContext?,
        isInScrollView: Bool = false,
        isPressed: Binding<Bool>,
        doubleTapAction: KeyboardGestureAction?,
        longPressAction: KeyboardGestureAction?,
        pressAction: KeyboardGestureAction?,
        releaseAction: KeyboardGestureAction?,
        repeatAction: KeyboardGestureAction?,
        dragAction: KeyboardDragGestureAction?
    ) {
        self.view = view
        self.action = action
        self.calloutContext = calloutContext
        self.isInScrollView = isInScrollView
        self.isPressed = isPressed
        self.doubleTapAction = doubleTapAction
        self.longPressAction = longPressAction
        self.pressAction = pressAction
        self.releaseAction = releaseAction
        self.repeatAction = repeatAction
        self.dragAction = dragAction
    }
    
    private let view: Content
    private let action: KeyboardAction?
    private let calloutContext: KeyboardCalloutContext?
    private let isInScrollView: Bool
    private let isPressed: Binding<Bool>
    private let doubleTapAction: KeyboardGestureAction?
    private let longPressAction: KeyboardGestureAction?
    private let pressAction: KeyboardGestureAction?
    private let releaseAction: KeyboardGestureAction?
    private let repeatAction: KeyboardGestureAction?
    private let dragAction: KeyboardDragGestureAction?

    @State
    private var isPressGestureActive = false {
        didSet { isPressed.wrappedValue = isPressGestureActive }
    }

    @State
    private var shouldApplyReleaseAction = true
    
    var body: some View {
        view.overlay(
            GeometryReader { geo in
                gestureButton(for: geo)
            }
        )
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

private extension KeyboardGestures {

    @ViewBuilder
    func gestureButton(for geo: GeometryProxy) -> some View {
        if isInScrollView {
            ScrollViewGestureButton(
                isPressed: isPressed,
                pressAction: { handlePress(in: geo) },
                releaseInsideAction: { handleReleaseInside(in: geo) },
                releaseOutsideAction: { handleReleaseOutside(in: geo) },
                longPressAction: { handleLongPress(in: geo) },
                doubleTapAction: { handleDoubleTap(in: geo) },
                repeatAction: { handleRepeat(in: geo) },
                dragAction: { handleDrag(in: geo, value: $0) },
                endAction: { handleGestureEnded(in: geo) },
                label: { _ in Color.clearInteractable }
            )
        } else {
            GestureButton(
                isPressed: isPressed,
                pressAction: { handlePress(in: geo) },
                releaseInsideAction: { handleReleaseInside(in: geo) },
                releaseOutsideAction: { handleReleaseOutside(in: geo) },
                longPressAction: { handleLongPress(in: geo) },
                doubleTapAction: { handleDoubleTap(in: geo) },
                repeatAction: { handleRepeat(in: geo) },
                dragAction: { handleDrag(in: geo, value: $0) },
                endAction: { handleGestureEnded(in: geo) },
                label: { _ in Color.clearInteractable }
            )
        }
    }
}


// MARK: - Actions

private extension KeyboardGestures {

    func handleDoubleTap(in geo: GeometryProxy) {
        doubleTapAction?()
    }

    func handleDrag(in geo: GeometryProxy, value: DragGesture.Value) {
        calloutContext?.action.updateSelection(with: value.translation)
        dragAction?(value.startLocation, value.location)
    }

    func handleGestureEnded(in geo: GeometryProxy) {
        endActionCallout()
        calloutContext?.input.resetWithDelay()
        calloutContext?.action.reset()
        shouldApplyReleaseAction = true
    }

    func handleLongPress(in geo: GeometryProxy) {
        shouldApplyReleaseAction = shouldApplyReleaseAction && action != .space
        tryBeginActionCallout(in: geo)
        longPressAction?()
    }

    func handlePress(in geo: GeometryProxy) {
        pressAction?()
        calloutContext?.input.updateInput(for: action, in: geo)
    }

    func handleReleaseInside(in geo: GeometryProxy) {
        updateShouldApplyReleaseAction()
        guard shouldApplyReleaseAction else { return }
        releaseAction?()
    }

    func handleReleaseOutside(in geo: GeometryProxy) {}

    func handleRepeat(in geo: GeometryProxy) {
        repeatAction?()
    }

    func tryBeginActionCallout(in geo: GeometryProxy) {
        guard let context = calloutContext?.action else { return }
        context.updateInputs(for: action, in: geo)
        guard context.isActive else { return }
        calloutContext?.input.reset()
    }

    func endActionCallout() {
        calloutContext?.action.endDragGesture()
    }

    func updateShouldApplyReleaseAction() {
        guard let context = calloutContext?.action else { return }
        shouldApplyReleaseAction = shouldApplyReleaseAction && !context.hasSelectedAction
    }
}
#endif
