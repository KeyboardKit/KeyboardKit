//
//  Gestures+GestureButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-24.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS)
import SwiftUI

public extension Gestures {
    
    @available(*, deprecated, message: "This is no longer used and will be removed in KeyboardKit 9.0")
    struct GestureButton<Label: View>: View {

        public init(
            isPressed: Binding<Bool>? = nil,
            pressAction: Action? = nil,
            cancelDelay: TimeInterval = Defaults.cancelDelay,
            releaseInsideAction: Action? = nil,
            releaseOutsideAction: Action? = nil,
            longPressDelay: TimeInterval = Defaults.longPressDelay,
            longPressAction: Action? = nil,
            doubleTapTimeout: TimeInterval = Defaults.doubleTapTimeout,
            doubleTapAction: Action? = nil,
            repeatDelay: TimeInterval = Defaults.repeatDelay,
            repeatTimer: Gestures.RepeatTimer = .shared,
            repeatAction: Action? = nil,
            dragStartAction: DragAction? = nil,
            dragAction: DragAction? = nil,
            dragEndAction: DragAction? = nil,
            endAction: Action? = nil,
            label: @escaping LabelBuilder
        ) {
            self.isPressedBinding = isPressed ?? .constant(false)
            self.pressAction = pressAction
            self.cancelDelay = cancelDelay
            self.releaseInsideAction = releaseInsideAction
            self.releaseOutsideAction = releaseOutsideAction
            self.longPressDelay = longPressDelay
            self.longPressAction = longPressAction
            self.doubleTapTimeout = doubleTapTimeout
            self.doubleTapAction = doubleTapAction
            self.repeatDelay = repeatDelay
            self.repeatTimer = repeatTimer
            self.repeatAction = repeatAction
            self.dragStartAction = dragStartAction
            self.dragAction = dragAction
            self.dragEndAction = dragEndAction
            self.endAction = endAction
            self.label = label
        }
        
        public typealias Action = () -> Void
        public typealias DragAction = (DragGesture.Value) -> Void
        public typealias LabelBuilder = (_ isPressed: Bool) -> Label
        
        var isPressedBinding: Binding<Bool>
        
        let pressAction: Action?
        let cancelDelay: TimeInterval
        let releaseInsideAction: Action?
        let releaseOutsideAction: Action?
        let longPressDelay: TimeInterval
        let longPressAction: Action?
        let doubleTapTimeout: TimeInterval
        let doubleTapAction: Action?
        let repeatDelay: TimeInterval
        let repeatTimer: Gestures.RepeatTimer
        let repeatAction: Action?
        let dragStartAction: DragAction?
        let dragAction: DragAction?
        let dragEndAction: DragAction?
        let endAction: Action?
        let label: LabelBuilder
        
        @State
        private var isPressed = false
        
        @State
        private var isRemoved = false

        @StateObject
        private var dates = DateStorage()

        public var body: some View {
            label(isPressed)
                .overlay(gestureView)
                .onChange(of: isPressed) { isPressedBinding.wrappedValue = $0 }
                .onDisappear { isRemoved = true }
                .accessibilityAddTraits(.isButton)
        }
    }
}

/// This class is used for mutable, non-observed state.
private class DateStorage: ObservableObject {

    var lastGestureDate = Date()
    var longPressDate = Date()
    var releaseDate = Date()
    var repeatDate = Date()
}

@available(*, deprecated, message: "This is no longer used")
private extension Gestures.GestureButton {

    var gestureView: some View {
        GeometryReader { geo in
            Color.clear
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            tryHandlePress(value)
                            dragAction?(value)
                        }
                        .onEnded { value in
                            tryHandleRelease(value, in: geo)
                        }
                )
        }
    }
}

@available(*, deprecated, message: "This is no longer used")
private extension Gestures.GestureButton {

    /// We should always reset the state when a gesture ends.
    func reset() {
        isPressed = false
        dates.longPressDate = Date()    // Why reset?
        dates.repeatDate = Date()
        repeatTimer.stop()

    }

    /// A press should trigger some actions and set up a few
    /// delays for other things to be handled.
    func tryHandlePress(_ value: DragGesture.Value) {
        dates.lastGestureDate = Date()
        if isPressed { return }
        isPressed = true
        pressAction?()
        dragStartAction?(value)
        tryTriggerCancelAfterDelay()
        tryTriggerLongPressAfterDelay()
        tryTriggerRepeatAfterDelay()
    }

    /// A release should always reset the pressed state, but
    /// should only proceed if the button is pressed.
    func tryHandleRelease(_ value: DragGesture.Value, in geo: GeometryProxy) {
        let isPressed = self.isPressed
        reset()
        if !isPressed { return }
        dates.releaseDate = tryTriggerDoubleTap() ? .distantPast : Date()
        dragEndAction?(value)
        if geo.contains(value.location) {
            releaseInsideAction?()
        } else {
            releaseOutsideAction?()
        }
        endAction?()
    }

    /// A button that's accidentally triggered when flicking
    /// a scroll view won't receive a drag gesture end event.
    /// This will cause the button to get stuck in a pressed
    /// state, with the callout still showing and the button
    /// being gray. This initial delay will try to fix those
    /// errors by cancelling the gesture if a single gesture
    /// event has been received when the delay triggers.
    func tryTriggerCancelAfterDelay() {
        let date = Date()
        dates.lastGestureDate = date
        let delay = cancelDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard dates.lastGestureDate == date else { return }
            reset()
            endAction?()
        }
    }

    func tryTriggerLongPressAfterDelay() {
        guard let action = longPressAction else { return }
        let date = Date()
        dates.longPressDate = date
        let delay = longPressDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if isRemoved { return }
            guard dates.longPressDate == date else { return }
            action()
        }
    }

    func tryTriggerRepeatAfterDelay() {
        guard let action = repeatAction else { return }
        let date = Date()
        dates.repeatDate = date
        let delay = repeatDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if isRemoved { return }
            guard dates.repeatDate == date else { return }
            repeatTimer.start(action: action)
        }
    }

    func tryTriggerDoubleTap() -> Bool {
        let interval = Date().timeIntervalSince(dates.releaseDate)
        let isDoubleTap = interval < doubleTapTimeout
        if isDoubleTap { doubleTapAction?() }
        return isDoubleTap
    }
}
#endif
