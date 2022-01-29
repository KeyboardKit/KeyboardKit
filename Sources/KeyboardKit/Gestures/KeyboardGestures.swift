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
 This view wraps a provided view and applies a collection of
 optional gesture actions to it.
 
 This view is internal. You should instead apply it with the
 `keyboardGestures` view modifier, which is public.
 */
struct KeyboardGestures<Content: View>: View {
    
    /**
     Apply a set of optional gesture actions to the provided
     view, for a certain keyboard action.
     
     - Parameters:
       - view: The view to apply the gestures to.
       - action: The keyboard action to trigger.
       - isPressed: Whether or not the button is pressed.
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
        isPressed: Binding<Bool>,
        tapAction: KeyboardGestureAction?,
        doubleTapAction: KeyboardGestureAction?,
        longPressAction: KeyboardGestureAction?,
        pressAction: KeyboardGestureAction?,
        releaseAction: KeyboardGestureAction?,
        repeatAction: KeyboardGestureAction?,
        dragAction: KeyboardDragGestureAction?) {
        self.view = view
        self.action = action
        self.isPressed = isPressed
        self.tapAction = tapAction
        self.doubleTapAction = doubleTapAction
        self.longPressAction = longPressAction
        self.pressAction = pressAction
        self.releaseAction = releaseAction
        self.repeatAction = repeatAction
        self.dragAction = dragAction
    }
    
    private let view: Content
    private let action: KeyboardAction?
    private let isPressed: Binding<Bool>
    private let tapAction: KeyboardGestureAction?
    private let doubleTapAction: KeyboardGestureAction?
    private let longPressAction: KeyboardGestureAction?
    private let pressAction: KeyboardGestureAction?
    private let releaseAction: KeyboardGestureAction?
    private let repeatAction: KeyboardGestureAction?
    private let dragAction: KeyboardDragGestureAction?
    
    /**
     The shared input callout context.
     
     `TODO` The context is resolved like this to avoid doing
     changes that affects many library views.
     */
    private var actionCalloutContext: ActionCalloutContext? {
        #if os(iOS)
        KeyboardInputViewController.shared.actionCalloutContext
        #else
        nil
        #endif
    }
    
    /**
     The shared input callout context.
     
     `TODO` The context is resolved like this to avoid doing
     changes that affects many library views.
     */
    private var inputCalloutContext: InputCalloutContext? {
        #if os(iOS)
        KeyboardInputViewController.shared.inputCalloutContext
        #else
        nil
        #endif
    }
    
    /**
     The shared repeat timer.
     
     For now, this context is resolved like this, to avoid a
     change that affects all topmost views in the library.
     */
    private let repeatTimer = RepeatGestureTimer.shared
    
    @State private var isRepeatGestureActive = false {
        didSet { isRepeatGestureActive ? startRepeatTimer() : stopRepeatTimer() }
    }
    
    @State private var shouldApplyTapAction = true
    
    var body: some View {
        view.overlay(GeometryReader { geo in
            Color.clearInteractable
                .gesture(dragGesture(for: geo))
                .optionalGesture(doubleTapGesture)
                .simultaneousGesture(longPressGesture)
                .simultaneousGesture(longPressDragGesture(for: geo))
        })
    }
}


// MARK: - Gestures

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
            .onChanged { _ in handlePress(in: geo) }
            .onEnded { handleRelease(in: geo, at: $0.location) }
    }
    
    /**
     This is a plain long press gesure.
     */
    var longPressGesture: some Gesture {
        LongPressGesture()
            .onEnded { _ in handleLongPressGesture() }
    }
    
    /**
     This is a drag gesture that starts after a long press.
     */
    func longPressDragGesture(for geo: GeometryProxy) -> some Gesture {
        LongPressGesture()
            .onEnded { _ in beginActionCallout(for: geo) }
            .sequenced(before: DragGesture(minimumDistance: 0))
            .onChanged {
                switch $0 {
                case .first: break
                case .second(_, let drag): handleDelayedDrag(drag)
                }
            }
            .onEnded { _ in endActionCallout() }
    }
}


// MARK: - Functions

private extension KeyboardGestures {
    
    func beginActionCallout(for geo: GeometryProxy) {
        guard let context = actionCalloutContext else { return }
        context.updateInputs(for: action, in: geo)
        guard context.isActive else { return }
        inputCalloutContext?.reset()
    }
    
    func endActionCallout() {
        guard let context = actionCalloutContext else { return }
        shouldApplyTapAction = shouldApplyTapAction && !context.hasSelectedAction
        context.endDragGesture()
    }
    
    func handleDelayedDrag(_ drag: DragGesture.Value?) {
        shouldApplyTapAction = shouldApplyTapAction && action != .space
        actionCalloutContext?.updateSelection(with: drag)
        guard let drag = drag else { return }
        dragAction?(drag.startLocation, drag.location)
    }
    
    func handleLongPressGesture() {
        longPressAction?()
        startRepeatTimer()
    }
    
    func handlePress(in geo: GeometryProxy) {
        if isPressed.wrappedValue { return }
        isPressed.wrappedValue = true
        pressAction?()
        inputCalloutContext?.updateInput(for: action, in: geo)
    }
    
    func handleRelease(in geo: GeometryProxy, at location: CGPoint) {
        releaseAction?()
        if geo.contains(location), shouldApplyTapAction {
            tapAction?()
        }
        shouldApplyTapAction = true
        isPressed.wrappedValue = false
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
