//
//  GestureButton.swift
//  GestureButton
//
//  Created by Daniel Saidi on 2022-11-24.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
import SwiftUI

/// This button can be used to trigger gesture-based actions.
///
/// A `cancelDelay` can be specified to make a button cancel
/// its gesture if no values are registered during the delay.
/// This can be used to avoid a button from getting stuck in
/// a pressed state, which for instance can happen when it's
/// placed next to a scroll view and touched by accident.
///
/// > Important: Make sure to use ``GestureButtonScrollState``
/// if the button is within a `ScrollView`, otherwise it may
/// block the scroll view gestures in iOS 17 and earlier and
/// trigger unwanted actions in iOS 18 and later.
public struct GestureButton<Label: View>: View {
    
    /// Create a gesture button.
    ///
    /// - Parameters:
    ///   - isPressed: A custom, optional binding to track pressed state, if any.
    ///   - scrollState: The scroll state to use, if any.
    ///   - pressAction: The action to trigger when the button is pressed, if any.
    ///   - cancelDelay: The time it takes for a cancelled press to cancel itself, if any.
    ///   - releaseInsideAction: The action to trigger when the button is released inside, if any.
    ///   - releaseOutsideAction: The action to trigger when the button is released outside of its bounds, if any.
    ///   - longPressDelay: The time it takes for a press to count as a long press, by default `0.5` seconds.
    ///   - longPressAction: The action to trigger when the button is long pressed, if any.
    ///   - doubleTapTimeout: The max time between two taps for them to count as a double tap, by default `0.2` seconds.
    ///   - doubleTapAction: The action to trigger when the button is double tapped, if any.
    ///   - repeatDelay: The time it takes for a press to start a repeating action, by default `0.5` seconds.
    ///   - repeatTimer: A custom repeat timer to use for the repeating action, if any.
    ///   - repeatAction: The action to repeat while the button is being pressed, if any.
    ///   - dragStartAction: The action to trigger when a drag gesture starts, if any.
    ///   - dragAction: The action to trigger when a drag gesture changes, if any.
    ///   - dragEndAction: The action to trigger when a drag gesture ends, if any.
    ///   - endAction: The action to trigger when a button gesture ends, if any.
    ///   - label: The button label.
    public init(
        isPressed: Binding<Bool>? = nil,
        scrollState: GestureButtonScrollState? = nil,
        pressAction: Action? = nil,
        cancelDelay: TimeInterval? = nil,
        releaseInsideAction: Action? = nil,
        releaseOutsideAction: Action? = nil,
        longPressDelay: TimeInterval? = nil,
        longPressAction: Action? = nil,
        doubleTapTimeout: TimeInterval? = nil,
        doubleTapAction: Action? = nil,
        repeatDelay: TimeInterval? = nil,
        repeatTimer: GestureButtonTimer? = nil,
        repeatAction: Action? = nil,
        dragStartAction: DragAction? = nil,
        dragAction: DragAction? = nil,
        dragEndAction: DragAction? = nil,
        endAction: Action? = nil,
        label: @escaping LabelBuilder
    ) {
        self._state = .init(wrappedValue: .init(
            isPressed: isPressed,
            cancelDelay: cancelDelay,
            longPressDelay: longPressDelay,
            doubleTapTimeout: doubleTapTimeout,
            repeatDelay: repeatDelay,
            repeatTimer: repeatTimer
        ))

        self.pressAction = pressAction
        self.releaseInsideAction = releaseInsideAction
        self.releaseOutsideAction = releaseOutsideAction
        self.longPressAction = longPressAction
        self.doubleTapAction = doubleTapAction
        self.repeatAction = repeatAction
        self.dragStartAction = dragStartAction
        self.dragAction = dragAction
        self.dragEndAction = dragEndAction
        self.endAction = endAction

        self.isInScrollView = scrollState != nil
        self._scrollState = .init(wrappedValue: scrollState ?? .init())
        self.label = label
    }

    public typealias Action = () -> Void
    public typealias DragAction = (DragGesture.Value) -> Void
    public typealias LabelBuilder = (_ isPressed: Bool) -> Label
    
    private let pressAction: Action?
    private let releaseInsideAction: Action?
    private let releaseOutsideAction: Action?
    private let longPressAction: Action?
    private let doubleTapAction: Action?
    private let repeatAction: Action?
    private let dragStartAction: DragAction?
    private let dragAction: DragAction?
    private let dragEndAction: DragAction?
    private let endAction: Action?

    @StateObject
    private var state: GestureButtonState

    @ObservedObject
    private var scrollState: GestureButtonScrollState

    private let isInScrollView: Bool
    private let label: LabelBuilder
    
    public var body: some View {
        if #available(iOS 18.0, macOS 15.0, watchOS 11.0, *) {
            content
        } else if isInScrollView {
            /// The `simultaneousGesture` below doesn't work
            /// in iOS 17 and `ScrollViewGestureButton` does
            /// only work in iOS 17 and earlier.
            ScrollViewGestureButton(
                isPressed: $state.isPressed,
                pressAction: pressAction,
                releaseInsideAction: releaseInsideAction,
                releaseOutsideAction: releaseOutsideAction,
                longPressDelay: state.longPressDelay,
                longPressAction: longPressAction,
                doubleTapTimeout: state.doubleTapTimeout,
                doubleTapAction: doubleTapAction,
                repeatDelay: state.repeatDelay,
                repeatAction: repeatAction,
                repeatTimer: state.repeatTimer,
                dragStartAction: dragStartAction,
                dragAction: dragAction,
                dragEndAction: dragEndAction,
                endAction: endAction,
                label: label
            )
        } else {
            content
        }
    }
    
    var content: some View {
        label(state.isPressed)
            .overlay(gestureView)
            .onDisappear { state.isRemoved = true }
            .accessibilityAddTraits(.isButton)
    }
}

private extension GestureButton {
    
    func gesture(
        for geo: GeometryProxy
    ) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { handleDrag($0) }
            .onEnded { handleDragEnded($0, in: geo) }
    }
    
    var gestureView: some View {
        GeometryReader { geo in
            Color.clear
                .contentShape(Rectangle())
                .simultaneousGesture(gesture(for: geo))
        }
    }
    
    func handleDrag(
        _ value: DragGesture.Value
    ) {
        if scrollState.isScrolling { return }
        if isInScrollView {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                handleDragWithState(value)
            }
        } else {
            handleDragWithState(value)
        }
    }
    
    func handleDragWithState(
        _ value: DragGesture.Value
    ) {
        state.lastGestureValue = value
        if scrollState.isScrolling { return }
        tryHandleDrag(value)
        if state.gestureWasStarted { return }
        state.gestureWasStarted = true
        setScrollGestureDisabledState(true)
        tryHandlePress(value)
    }
    
    func handleDragEnded(_ value: DragGesture.Value, in geo: GeometryProxy) {
        if isInScrollView {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                handleDragEndedWithState(value, in: geo)
            }
        } else {
            handleDragEndedWithState(value, in: geo)
        }
    }
    
    func handleDragEndedWithState(
        _ value: DragGesture.Value,
        in geo: GeometryProxy
    ) {
        defer { resetGestureWasStarted() }
        guard state.gestureWasStarted else { return }
        setScrollGestureDisabledState(false)
        tryHandleRelease(value, in: geo)
    }

    func handleRepeatAction() {
        guard let repeatAction else { return }
        repeatAction()
    }

    func reset() {
        state.isPressed = false
        state.longPressDate = Date()
        state.repeatDate = Date()
        tryStopRepeatTimer()
    }

    func resetGestureWasStarted() {
        state.gestureWasStarted = false
    }
    
    func setScrollGestureDisabledState(_ new: Bool) {
        if scrollState.isScrollGestureDisabled == new { return }
        scrollState.isScrollGestureDisabled = new
    }
}

private extension GestureButton {

    func tryHandlePress(_ value: DragGesture.Value) {
        if state.isPressed { return }
        state.isPressed = true
        pressAction?()
        dragStartAction?(value)
        tryTriggerCancelAfterDelay()
        tryTriggerLongPressAfterDelay()
        tryTriggerRepeatAfterDelay()
    }

    /// Try to handle any new drag gestures as a press event.
    func tryHandleDrag(_ value: DragGesture.Value) {
        guard state.isPressed else { return }
        dragAction?(value)
    }

    /// This function will trigger several actions, based on
    /// how the gesture is ended. It will always trigger the
    /// drag end and end actions, then either of the release
    /// inside or outside actions.
    func tryHandleRelease(_ value: DragGesture.Value, in geo: GeometryProxy) {
        let shouldTrigger = state.isPressed
        reset()
        guard shouldTrigger else { return }
        state.releaseDate = tryTriggerDoubleTap() ? .distantPast : Date()
        dragEndAction?(value)
        if geo.contains(value.location) {
            releaseInsideAction?()
        } else {
            releaseOutsideAction?()
        }
        endAction?()
    }

    /// This function tries to fix an iOS bug, where buttons
    /// may not always receive a gesture end event. This can
    /// for instance happen when the button is near a scroll
    /// view and is accidentally touched when a user scrolls.
    /// The function checks if the original gesture is still
    /// the last gesture when the cancel delay triggers, and
    /// will if so cancel the gesture. Since this will cause
    /// completely still gestures to be seen as accidentally
    /// triggered, this function can yield incorrect results
    /// and should be replaced by a proper bug fix.
    func tryTriggerCancelAfterDelay() {
        guard let delay = state.cancelDelay else { return }
        let value = state.lastGestureValue
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard state.lastGestureValue?.location == value?.location else { return }
            self.reset()
            self.endAction?()
        }
    }

    /// This function tries to trigger the double tap action
    /// if the current date is within the double tap timeout
    /// since the last release.
    func tryTriggerDoubleTap() -> Bool {
        let interval = Date().timeIntervalSince(state.releaseDate)
        let isDoubleTap = interval < state.doubleTapTimeout
        if isDoubleTap { doubleTapAction?() }
        return isDoubleTap
    }

    /// This function tries to trigger the long press action
    /// after the specified long press delay.
    func tryTriggerLongPressAfterDelay() {
        guard let action = longPressAction else { return }
        let date = Date()
        state.longPressDate = date
        let delay = state.longPressDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if state.isRemoved { return }
            guard state.longPressDate == date else { return }
            action()
        }
    }

    /// This function tries to start a repeat action trigger
    /// timer after repeat delay.
    func tryTriggerRepeatAfterDelay() {
        let date = Date()
        state.repeatDate = date
        let delay = state.repeatDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if state.isRemoved { return }
            guard state.repeatDate == date else { return }
            self.tryStartRepeatTimer()
        }
    }

    /// Try to start the repeat timer.
    func tryStartRepeatTimer() {
        if state.repeatTimer.isActive { return }
        state.repeatTimer.start {
            Task { await handleRepeatAction() }
        }
    }

    /// Try to stop the repeat timer.
    func tryStopRepeatTimer() {
        guard state.repeatTimer.isActive else { return }
        state.repeatTimer.stop()
    }
}

#Preview {
    
    struct Preview: View {

        @StateObject var state = GestureButtonPreview.State()
        @StateObject var scrollState = GestureButtonScrollState()

        var body: some View {
            GestureButtonPreview.Content(state: state) {
                GestureButton(
                    isPressed: $state.isPressed,
                    scrollState: scrollState,
                    pressAction: { state.pressCount += 1 },
                    releaseInsideAction: { state.releaseInsideCount += 1 },
                    releaseOutsideAction: { state.releaseOutsideCount += 1 },
                    longPressDelay: 0.8,
                    longPressAction: { state.longPressCount += 1 },
                    doubleTapAction: { state.doubleTapCount += 1 },
                    repeatAction: { state.repeatCount += 1 },
                    dragStartAction: { state.dragStartValue = $0.location },
                    dragAction: { state.dragChangedValue = $0.location },
                    dragEndAction: { state.dragEndValue = $0.location },
                    endAction: { state.endCount += 1 },
                    label: { GestureButtonPreview.Item(isPressed: $0) }
                )
            }
        }
    }
    
    return Preview()
}
#endif
