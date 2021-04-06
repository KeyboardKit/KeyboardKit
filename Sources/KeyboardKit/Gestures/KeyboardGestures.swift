//
//  KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view wraps a view then applies keyboard gestures to it.
 It can be applied with the `keyboardGestures` view modifier.
 */
struct KeyboardGestures<Content: View>: View {
    
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
                .simultaneousGesture(tapGesture)
                .simultaneousGesture(doubleTapGesture)
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
    var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            doubleTapAction?()
            triggerPressedHighlight()
        }
    }
    
    /**
     This is a drag gesture that starts immediately.
     */
    func dragGesture(for geo: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
                handlePressGesture(for: geo) }
            .onEnded { _ in
                handleReleaseGesture()
                }
    }
    
    /**
     This is a plain long press gesure.
     */
    var longPressGesture: some Gesture {
        LongPressGesture().onEnded { _ in
            longPressAction?()
            startRepeatTimer()
        }
    }
    
    /**
     This is a drag gesture that starts after a long press.
     */
    func longPressDragGesture(for geo: GeometryProxy) -> some Gesture {
        LongPressGesture()
            .onEnded { _ in beginSecondaryInputGesture(for: geo) }
            .sequenced(before: DragGesture(minimumDistance: 0))
            .onChanged {
                switch $0 {
                case .first: break
                case .second(_, let drag): handleSecondaryInputDragGesture(drag)
                }
            }
            .onEnded { _ in endSecondaryInputGesture() }
    }
    
    /**
     This is a plain tap gesure.
     */
    var tapGesture: some Gesture {
        TapGesture().onEnded {
            tapAction?()
            triggerPressedHighlight()
            inputCalloutContext.reset()
        }
    }
}


// MARK: - Functions

private extension KeyboardGestures {
    
    var shouldTapAfterSecondaryInputGesture: Bool {
        dragAction == nil && longPressAction == nil && repeatAction == nil && !secondaryInputCalloutContext.isActive
    }
    
    func beginSecondaryInputGesture(for geo: GeometryProxy) {
        isInputCalloutEnabled = false
        secondaryInputCalloutContext.updateInputs(for: action, geo: geo)
        guard secondaryInputCalloutContext.isActive else { return }
        inputCalloutContext.reset()
    }
    
    func endSecondaryInputGesture() {
        isInputCalloutEnabled = true
        if shouldTapAfterSecondaryInputGesture { tapAction?() }
        secondaryInputCalloutContext.endDragGesture()
        guard secondaryInputCalloutContext.isActive else { return }
    }
    
    func handlePressGesture(for geo: GeometryProxy) {
        if isDragGestureTriggered { return }
        isDragGestureTriggered = true
        pressAction?()
        isPressed.wrappedValue = true
        guard isInputCalloutEnabled else { return }
        inputCalloutContext.updateInput(for: action, geo: geo)
    }
    
    func handleReleaseGesture() {
        releaseAction?()
        isDragGestureTriggered = false
        isPressed.wrappedValue = false
        inputCalloutContext.reset()
        stopRepeatTimer()
    }
    
    func handleSecondaryInputDragGesture(_ drag: DragGesture.Value?) {
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
    
    func triggerPressedHighlight() {
        if isInputCalloutEnabled { return }
        isPressed.wrappedValue = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPressed.wrappedValue = false
        }
    }
}
