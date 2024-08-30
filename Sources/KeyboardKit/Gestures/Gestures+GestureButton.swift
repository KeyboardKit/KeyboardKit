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
    
    /// This button supports triggering gesture actions in a
    /// way that maximizes performance.
    ///
    /// This button can however not be used in a `ScrollView`
    /// since it blocks the scroll view gesture.
    ///
    /// Use a ``Gestures/ScrollViewGestureButton`` when your
    /// buttons won't be used within `ScrollView`.
    struct GestureButton<Label: View>: View {
        
        /// Create a scroll gesture button.
        ///
        /// - Parameters:
        ///   - isPressed: A custom, optional binding to track pressed state, by default `nil`.
        ///   - pressAction: The action to trigger when the button is pressed, by default `nil`.
        ///   - canceDelay: The time it takes for a cancelled press to cancel itself.
        ///   - releaseInsideAction: The action to trigger when the button is released inside, by default `nil`.
        ///   - releaseOutsideAction: The action to trigger when the button is released outside of its bounds, by default `nil`.
        ///   - longPressDelay: The time it takes for a press to count as a long press.
        ///   - longPressAction: The action to trigger when the button is long pressed, by default `nil`.
        ///   - doubleTapTimeout: The max time between two taps for them to count as a double tap.
        ///   - doubleTapAction: The action to trigger when the button is double tapped, by default `nil`.
        ///   - repeatDelay: The time it takes for a press to count as a repeat trigger.
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

private extension GeometryProxy {

    func contains(_ dragEndLocation: CGPoint) -> Bool {
        let x = dragEndLocation.x
        let y = dragEndLocation.y
        guard x > 0, y > 0 else { return false }
        guard x < size.width, y < size.height else { return false }
        return true
    }
}

#Preview {

    struct Preview: View {

        @StateObject
        var state = PreviewState()

        @State
        private var items = (1...3).map { PreviewItem(id: $0) }

        var body: some View {
            VStack(spacing: 20) {

                PreviewHeader(state: state)
                    .padding(.horizontal)

                PreviewButtonGroup(title: "Buttons:") {
                    Gestures.GestureButton(
                        isPressed: $state.isPressed,
                        pressAction: { state.pressCount += 1 },
                        releaseInsideAction: { state.releaseInsideCount += 1 },
                        releaseOutsideAction: { state.releaseOutsideCount += 1 },
                        longPressDelay: 0.8,
                        longPressAction: { state.longPressCount += 1 },
                        doubleTapAction: { state.doubleTapCount += 1 },
                        repeatAction: { state.repeatTapCount += 1 },
                        dragStartAction: { state.dragStartedValue = $0.location },
                        dragAction: { state.dragChangedValue = $0.location },
                        dragEndAction: { state.dragEndedValue = $0.location },
                        endAction: { state.endCount += 1 },
                        label: { PreviewButton(color: .blue, isPressed: $0) }
                    )
                }
            }
        }
    }

    struct PreviewItem: Identifiable {

        var id: Int
    }

    struct PreviewButton: View {

        let color: Color
        let isPressed: Bool

        var body: some View {
            color
                .cornerRadius(10)
                .opacity(isPressed ? 0.5 : 1)
                .scaleEffect(isPressed ? 0.9 : 1)
                .animation(.default, value: isPressed)
                .padding()
                .background(Color.random())
                .cornerRadius(16)
        }
    }

    struct PreviewButtonGroup<Content: View>: View {

        let title: String
        let button: () -> Content

        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                HStack {
                    ForEach(0...3, id: \.self) { _ in
                        button()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
        }
    }

    class PreviewState: ObservableObject {

        @Published
        var isPressed = false

        @Published
        var pressCount = 0

        @Published
        var releaseInsideCount = 0

        @Published
        var releaseOutsideCount = 0

        @Published
        var endCount = 0

        @Published
        var longPressCount = 0

        @Published
        var doubleTapCount = 0

        @Published
        var repeatTapCount = 0

        @Published
        var dragStartedValue = CGPoint.zero

        @Published
        var dragChangedValue = CGPoint.zero

        @Published
        var dragEndedValue = CGPoint.zero
    }

    struct PreviewHeader: View {

        @ObservedObject
        var state: PreviewState

        var body: some View {
            VStack(alignment: .leading) {
                Group {
                    label("Pressed", state.isPressed ? "YES" : "NO")
                    label("Presses", state.pressCount)
                    label("Releases", state.releaseInsideCount + state.releaseOutsideCount)
                    label("     Inside", state.releaseInsideCount)
                    label("     Outside", state.releaseOutsideCount)
                    label("Ended", state.endCount)
                    label("Long presses", state.longPressCount)
                    label("Double taps", state.doubleTapCount)
                    label("Repeats", state.repeatTapCount)
                }
                Group {
                    label("Drag started", state.dragStartedValue)
                    label("Drag changed", state.dragChangedValue)
                    label("Drag ended", state.dragEndedValue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).stroke(.blue, lineWidth: 3))
        }

        func label(_ title: String, _ int: Int) -> some View {
            label(title, "\(int)")
        }

        func label(_ title: String, _ point: CGPoint) -> some View {
            label(title, "\(point.x.rounded()), \(point.y.rounded())")
        }

        func label(_ title: String, _ value: String) -> some View {
            HStack {
                Text("\(title):")
                Text(value).bold()
            }
            .lineLimit(1)
        }
    }

    return Preview()
}
#endif
