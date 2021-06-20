//
//  KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view wraps a provided view and applies a collection of
 optional gesture actions to it.
 
 Although this view is internal, is can be created using the
 public `keyboardGestures` view modifier.
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
    
    @EnvironmentObject private var inputCalloutContext: InputCalloutContext
    @EnvironmentObject private var secondaryInputCalloutContext: SecondaryInputCalloutContext
    
    private let repeatTimer = RepeatGestureTimer.shared
    
    @State private var isDragGestureTriggered = false
    @State private var isInputCalloutEnabled = true
    @State private var isRepeatGestureActive = false {
        didSet { isRepeatGestureActive ? startRepeatTimer() : stopRepeatTimer() }
    }
    
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
            .onEnded { _ in beginSecondaryInput(for: geo) }
            .sequenced(before: DragGesture(minimumDistance: 0))
            .onChanged {
                switch $0 {
                case .first: break
                case .second(_, let drag): handleSecondaryInputDrag(drag)
                }
            }
            .onEnded { _ in endSecondaryInput() }
    }
}


// MARK: - Functions

private extension KeyboardGestures {
    
    var shouldTapAfterSecondaryInputGesture: Bool {
        dragAction == nil && longPressAction == nil && repeatAction == nil && !secondaryInputCalloutContext.isActive
    }
    
    func beginSecondaryInput(for geo: GeometryProxy) {
        isInputCalloutEnabled = false
        secondaryInputCalloutContext.updateInputs(for: action, geo: geo)
        guard secondaryInputCalloutContext.isActive else { return }
        inputCalloutContext.reset()
    }
    
    func endSecondaryInput() {
        isInputCalloutEnabled = true
        if shouldTapAfterSecondaryInputGesture { tapAction?() }
        secondaryInputCalloutContext.endDragGesture()
        guard secondaryInputCalloutContext.isActive else { return }
    }
    
    func handleLongPressGesture() {
        longPressAction?()
        startRepeatTimer()
    }
    
    func handlePress(in geo: GeometryProxy) {
        if isDragGestureTriggered { return }
        isDragGestureTriggered = true
        pressAction?()
        isPressed.wrappedValue = true
        guard isInputCalloutEnabled else { return }
        inputCalloutContext.updateInput(for: action, geo: geo)
    }
    
    func handleRelease(in geo: GeometryProxy, at location: CGPoint) {
        releaseAction?()
        if geo.contains(location) {
            tapAction?()
        }
        isDragGestureTriggered = false
        isPressed.wrappedValue = false
        inputCalloutContext.reset()
        stopRepeatTimer()
    }
    
    func handleSecondaryInputDrag(_ drag: DragGesture.Value?) {
        secondaryInputCalloutContext.updateSelection(with: drag)
        guard let drag = drag else { return }
        dragAction?(drag.startLocation, drag.location)
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
