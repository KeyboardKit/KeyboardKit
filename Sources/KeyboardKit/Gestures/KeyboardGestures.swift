//
//  KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
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
       - isInScrollView: Whether or not the gestures are used in a scroll view.
       - isPressed: An optional binding that can be used to observe the button pressed state.
       - tapAction: The action to trigger when the button is released within its bounds.
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
        isInScrollView: Bool = false,
        isPressed: Binding<Bool>,
        tapAction: KeyboardGestureAction?,
        doubleTapAction: KeyboardGestureAction?,
        longPressAction: KeyboardGestureAction?,
        pressAction: KeyboardGestureAction?,
        releaseAction: KeyboardGestureAction?,
        repeatAction: KeyboardGestureAction?,
        repeatTimer: RepeatGestureTimer = .shared,
        dragAction: KeyboardDragGestureAction?
    ) {
        self.view = view
        self.action = action
        self.isInScrollView = isInScrollView
        self.isPressed = isPressed
        self.tapAction = tapAction
        self.doubleTapAction = doubleTapAction
        self.longPressAction = longPressAction
        self.pressAction = pressAction
        self.releaseAction = releaseAction
        self.repeatAction = repeatAction
        self.repeatTimer = repeatTimer
        self.dragAction = dragAction
    }
    
    private let view: Content
    private let action: KeyboardAction?
    private let isInScrollView: Bool
    private let isPressed: Binding<Bool>
    private let tapAction: KeyboardGestureAction?
    private let doubleTapAction: KeyboardGestureAction?
    private let longPressAction: KeyboardGestureAction?
    private let pressAction: KeyboardGestureAction?
    private let releaseAction: KeyboardGestureAction?
    private let repeatAction: KeyboardGestureAction?
    private let repeatTimer: RepeatGestureTimer
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
                if #available(iOS 14.0, macOS 11.0, watchOS 8.0, *) {
                    gestureButton(for: geo)
                } else {
                    Color.clearInteractable
                        .gesture(dragGesture(for: geo))
                        .optionalGesture(doubleTapGesture)
                        .simultaneousGesture(longPressGesture)
                        .simultaneousGesture(longPressDragGesture(for: geo))
                }
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
    @available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
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


// MARK: - Contexts

private extension KeyboardGestures {

    var actionCalloutContext: ActionCalloutContext? { .shared }

    var inputCalloutContext: InputCalloutContext? { .shared }
}


// MARK: - Actions

private extension KeyboardGestures {

    func handleDoubleTap(in geo: GeometryProxy) {
        doubleTapAction?()
    }

    func handleDrag(in geo: GeometryProxy, value: DragGesture.Value) {
        actionCalloutContext?.updateSelection(with: value)
        dragAction?(value.startLocation, value.location)
    }

    func handleGestureEnded(in geo: GeometryProxy) {
        endActionCallout()
        inputCalloutContext?.resetWithDelay()
        actionCalloutContext?.reset()
        shouldApplyReleaseAction = true
    }

    func handleLongPress(in geo: GeometryProxy) {
        shouldApplyReleaseAction = shouldApplyReleaseAction && action != .space
        tryBeginActionCallout(in: geo)
        longPressAction?()
    }

    func handlePress(in geo: GeometryProxy) {
        pressAction?()
        inputCalloutContext?.updateInput(for: action, in: geo)
    }

    func handleReleaseInside(in geo: GeometryProxy) {
        updateShouldApplyReleaseAction()
        guard shouldApplyReleaseAction else { return }
        tapAction?()
        releaseAction?()
    }

    func handleReleaseOutside(in geo: GeometryProxy) {}

    func handleRepeat(in geo: GeometryProxy) {
        repeatAction?()
    }

    func tryBeginActionCallout(in geo: GeometryProxy) {
        guard let context = actionCalloutContext else { return }
        context.updateInputs(for: action, in: geo)
        guard context.isActive else { return }
        inputCalloutContext?.reset()
    }

    func endActionCallout() {
        actionCalloutContext?.endDragGesture()
    }

    func updateShouldApplyReleaseAction() {
        guard let context = actionCalloutContext else { return }
        shouldApplyReleaseAction = shouldApplyReleaseAction && !context.hasSelectedAction
    }
}


// MARK: - Legacy Gestures

private extension KeyboardGestures {
    
    /**
     This is a plain double-tap gesure.
     */
    var doubleTapGesture: _EndedGesture<TapGesture>? {
        guard let action = doubleTapAction else { return nil }
        return TapGesture(count: 2)
            .onEnded { action() }
    }

    /**
     This drag gesture is the most central gesture and takes
     care of press, release, tap and drag action handling.
     */
    func dragGesture(for geo: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in tryHandlePress(in: geo) }
            .onEnded { handleLegacyRelease(in: geo, at: $0.location) }
    }
    
    /**
     This is a plain long press gesure.
     */
    var longPressGesture: some Gesture {
        LongPressGesture()
            .onEnded { _ in handleLegacyLongPressGesture() }
    }
    
    /**
     This is a drag gesture that starts after a long press.

     This gesture is used to present and dismiss the callout
     that presents secondary actions.
     */
    func longPressDragGesture(for geo: GeometryProxy) -> some Gesture {
        LongPressGesture(minimumDuration: 0.4, maximumDistance: 50)
            .onEnded { _ in tryBeginActionCallout(in: geo) }
            .sequenced(before: DragGesture(minimumDistance: 0))
            .onChanged {
                switch $0 {
                case .first: break
                case .second(_, let value): handleDelayedDrag(value, in: geo)
                }
            }
            .onEnded { _ in endActionCallout() }
    }
}


// MARK: - Legacy Functions

private extension KeyboardGestures {
    
    func handleDelayedDrag(_ value: DragGesture.Value?, in geo: GeometryProxy) {
        shouldApplyReleaseAction = shouldApplyReleaseAction && action != .space
        actionCalloutContext?.updateSelection(with: value)
        guard let value = value else { return }
        handleDrag(in: geo, value: value)
        dragAction?(value.startLocation, value.location)
    }

    func handleLegacyLongPressGesture() {
        longPressAction?()
        startRepeatTimer()
    }
    
    func handleLegacyRelease(in geo: GeometryProxy, at location: CGPoint) {
        if geo.contains(location), shouldApplyReleaseAction {
            releaseAction?()
            tapAction?()
        }
        shouldApplyReleaseAction = true
        isPressGestureActive = false
        inputCalloutContext?.reset()
        stopRepeatTimer()
    }
    
    func startRepeatTimer() {
        guard let action = repeatAction else { return repeatTimer.stop() }
        repeatTimer.start(action: action)
    }
    
    func stopRepeatTimer() {
        repeatTimer.stop()
    }

    func tryHandlePress(in geo: GeometryProxy) {
        if isPressGestureActive { return }
        isPressGestureActive = true
        pressAction?()
        inputCalloutContext?.updateInput(for: action, in: geo)
    }
}


// MARK: - GeometryProxy Extension

private extension GeometryProxy {
    
    func contains(_ dragEndLocation: CGPoint) -> Bool {
        let x = dragEndLocation.x
        let y = dragEndLocation.y
        guard x > 0, y > 0 else { return false }
        guard x < size.width, y < size.height else { return false }
        return true
    }
}
#endif
