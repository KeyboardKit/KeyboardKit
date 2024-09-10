//
//  Gestures+ScrollViewGestureButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-16.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS)
import SwiftUI

public extension Gestures {
    
    @available(*, deprecated, message: "This is no longer used and will be removed in KeyboardKit 9.0")
    struct ScrollViewGestureButton<Label: View>: View {
        
        /// Create a scroll view gesture button.
        ///
        /// - Parameters:
        ///   - isPressed: A custom, optional binding to track pressed state, by default `nil`.
        ///   - pressAction: The action to trigger when the button is pressed, by default `nil`.
        ///   - releaseInsideAction: The action to trigger when the button is released inside, by default `nil`.
        ///   - releaseOutsideAction: The action to trigger when the button is released outside of its bounds, by default `nil`.
        ///   - longPressDelay: The time it takes for a press to count as a long press.
        ///   - longPressAction: The action to trigger when the button is long pressed, by default `nil`.
        ///   - doubleTapTimeout: The max time between two taps for them to count as a double tap.
        ///   - doubleTapAction: The action to trigger when the button is double tapped, by default `nil`.
        ///   - repeatTimer: The repeat timer to use for the repeat action.
        ///   - repeatAction: The action to repeat while the button is being pressed, by default `nil`.
        ///   - dragStartAction: The action to trigger when a drag gesture starts.
        ///   - dragAction: The action to trigger when a drag gesture changes.
        ///   - dragEndAction: The action to trigger when a drag gesture ends.
        ///   - endAction: The action to trigger when a button gesture ends, by default `nil`.
        ///   - label: The button label.
        public init(
            isPressed: Binding<Bool>? = nil,
            pressAction: Action? = nil,
            releaseInsideAction: Action? = nil,
            releaseOutsideAction: Action? = nil,
            longPressDelay: TimeInterval = Defaults.longPressDelay,
            longPressAction: Action? = nil,
            doubleTapTimeout: TimeInterval = Defaults.doubleTapTimeout,
            doubleTapAction: Action? = nil,
            repeatTimer: Gestures.RepeatTimer = .shared,
            repeatAction: Action? = nil,
            dragStartAction: DragAction? = nil,
            dragAction: DragAction? = nil,
            dragEndAction: DragAction? = nil,
            endAction: Action? = nil,
            label: @escaping LabelBuilder
        ) {
            self.isPressedBinding = isPressed ?? .constant(false)
            self._config = State(wrappedValue: GestureConfiguration(
                state: GestureState(),
                pressAction: pressAction ?? {},
                releaseInsideAction: releaseInsideAction ?? {},
                releaseOutsideAction: releaseOutsideAction ?? {},
                longPressDelay: longPressDelay,
                longPressAction: longPressAction ?? {},
                doubleTapTimeout: doubleTapTimeout,
                doubleTapAction: doubleTapAction ?? {},
                repeatTimer: repeatTimer,
                repeatAction: repeatAction,
                dragStartAction: dragStartAction,
                dragAction: dragAction,
                dragEndAction: dragEndAction,
                endAction: endAction ?? {},
                label: label
            ))
        }
        
        public typealias Action = () -> Void
        public typealias DragAction = (DragGesture.Value) -> Void
        public typealias LabelBuilder = (_ isPressed: Bool) -> Label
        
        var isPressedBinding: Binding<Bool>
        
        @State
        var config: GestureConfiguration
        
        @State
        private var isPressed = false
        
        @State
        private var isPressedByGesture = false
        
        public var body: some View {
            Button(action: config.releaseInsideAction) {
                config.label(isPressed)
                    .withDragGestureActions(
                        for: self.config,
                        isPressed: $isPressed,
                        isPressedByGesture: $isPressedByGesture
                    )
            }
            .buttonStyle(
                Style(
                    isPressed: $isPressed,
                    isPressedByGesture: $isPressedByGesture,
                    config: config
                )
            )
            .onChange(of: isPressed) { newValue in
                isPressedBinding.wrappedValue = newValue
            }
            .onChange(of: isPressedByGesture) { newValue in
                isPressed = newValue
            }
        }
    }
}

@available(*, deprecated, message: "This is no longer used")
extension Gestures.ScrollViewGestureButton {

    class GestureState: ObservableObject {

        @Published
        var doubleTapDate = Date()
    }

    struct GestureConfiguration {
        let state: GestureState
        let pressAction: Action
        let releaseInsideAction: Action
        let releaseOutsideAction: Action
        let longPressDelay: TimeInterval
        let longPressAction: Action
        let doubleTapTimeout: TimeInterval
        let doubleTapAction: Action
        let repeatTimer: Gestures.RepeatTimer
        let repeatAction: Action?
        let dragStartAction: DragAction?
        let dragAction: DragAction?
        let dragEndAction: DragAction?
        let endAction: Action
        let label: LabelBuilder

        func tryStartRepeatTimer() {
            if repeatTimer.isActive { return }
            guard let action = repeatAction else { return }
            repeatTimer.start(action: action)
        }

        func tryStopRepeatTimer() {
            guard repeatTimer.isActive else { return }
            repeatTimer.stop()
        }

        func tryTriggerDoubleTap() {
            let interval = Date().timeIntervalSince(state.doubleTapDate)
            let trigger = interval < doubleTapTimeout
            state.doubleTapDate = trigger ? .distantPast : Date()
            guard trigger else { return }
            doubleTapAction()
        }
    }

    struct Style: ButtonStyle {
        var isPressed: Binding<Bool>
        var isPressedByGesture: Binding<Bool>
        var config: GestureConfiguration

        @State
        var longPressDate = Date()

        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .onChange(of: configuration.isPressed) { isPressed in
                    longPressDate = Date()
                    if isPressed {
                        handleIsPressed()
                    } else {
                        handleIsEnded()
                    }
                }
        }
    }
}

@available(*, deprecated, message: "This is no longer used")
private extension Gestures.ScrollViewGestureButton.Style {

    func handleIsPressed() {
        isPressed.wrappedValue = true
        config.pressAction()
        tryTriggerLongPressAfterDelay(triggered: longPressDate)
    }

    func handleIsEnded() {
        if isPressedByGesture.wrappedValue { return }
        isPressed.wrappedValue = false
        config.endAction()
    }

    func tryTriggerLongPressAfterDelay(triggered date: Date) {
        DispatchQueue.main.asyncAfter(deadline: .now() + config.longPressDelay) {
            guard date == longPressDate else { return }
            config.longPressAction()
        }
    }
}

@available(*, deprecated, message: "This is no longer used")
private extension View {

    typealias Action = () -> Void
    typealias DragAction = (DragGesture.Value) -> Void

    @ViewBuilder
    func withDragGestureActions<Label: View>(
        for config: Gestures.ScrollViewGestureButton<Label>.GestureConfiguration,
        isPressed: Binding<Bool>,
        isPressedByGesture: Binding<Bool>
    ) -> some View {
        self.overlay(
            GeometryReader { geo in
                gesture(
                    TapGesture(count: 1).onEnded { _ in
                        let pressed = isPressed.wrappedValue
                        if !pressed { config.pressAction() }
                        toggleIsPressedForQuickTap(isPressed)
                        config.releaseInsideAction()
                        config.tryTriggerDoubleTap()
                        if !pressed { config.endAction() }
                    }
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if !isPressedByGesture.wrappedValue {
                                config.dragStartAction?(value)
                            }
                            isPressedByGesture.wrappedValue = true
                            config.dragAction?(value)
                            if config.longPressDelay > 0.6 && !config.repeatTimer.isActive {
                                config.longPressAction()
                            }
                            config.tryStartRepeatTimer()
                        }
                        .onEnded { value in
                            config.dragEndAction?(value)
                            isPressedByGesture.wrappedValue = false
                            config.tryStopRepeatTimer()
                            if geo.contains(value.location) {
                                config.releaseInsideAction()
                            } else {
                                config.releaseOutsideAction()
                            }
                            config.endAction()
                        }
                )
            }
        )
    }

    func toggleIsPressedForQuickTap(_ isPressed: Binding<Bool>) {
        isPressed.wrappedValue = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPressed.wrappedValue = false
        }
    }
}
#endif
