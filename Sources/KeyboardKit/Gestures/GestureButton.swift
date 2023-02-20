//
//  GestureButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-24.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS)
import SwiftUI

/**
 This button uses a single drag gesture to implement support
 for a bunch of different gestures.

 This button can not be used within a `ScrollView`, since it
 will block the scroll gestures. For these cases, you should
 consider using a ``ScrollViewGestureButton`` instead.
 */
public struct GestureButton<Label: View>: View {

    /**
     Create a drag gesture button.

     - Parameters:
       - isPressed: A custom, optional binding to track pressed state, by default `nil`.
       - pressAction: The action to trigger when the button is pressed, by default `nil`.
       - releaseInsideAction: The action to trigger when the button is released inside, by default `nil`.
       - releaseOutsideAction: The action to trigger when the button is released outside of its bounds, by default `nil`.
       - longPressDelay: The time it takes for a press to count as a long press, by default ``GestureButtonDefaults/longPressDelay``.
       - longPressAction: The action to trigger when the button is long pressed, by default `nil`.
       - doubleTapTimeout: The max time between two taps for them to count as a double tap, by default ``GestureButtonDefaults/doubleTapTimeout``.
       - doubleTapAction: The action to trigger when the button is double tapped, by default `nil`.
       - repeatDelay: The time it takes for a press to count as a repeat trigger, by default ``GestureButtonDefaults/repeatDelay``.
       - repeatTimer: The repeat timer to use for the repeat action, by default ``RepeatGestureTimer/shared``.
       - repeatAction: The action to repeat while the button is being pressed, by default `nil`.
       - dragStartAction: The action to trigger when a drag gesture starts.
       - dragAction: The action to trigger when a drag gesture changes.
       - dragEndAction: The action to trigger when a drag gesture ends.
       - endAction: The action to trigger when a button gesture ends, by default `nil`.
       - label: The button label.
     */
    init(
        isPressed: Binding<Bool>? = nil,
        pressAction: Action? = nil,
        releaseInsideAction: Action? = nil,
        releaseOutsideAction: Action? = nil,
        longPressDelay: TimeInterval = GestureButtonDefaults.longPressDelay,
        longPressAction: Action? = nil,
        doubleTapTimeout: TimeInterval = GestureButtonDefaults.doubleTapTimeout,
        doubleTapAction: Action? = nil,
        repeatDelay: TimeInterval = GestureButtonDefaults.repeatDelay,
        repeatTimer: RepeatGestureTimer = .shared,
        repeatAction: Action? = nil,
        dragStartAction: DragAction? = nil,
        dragAction: DragAction? = nil,
        dragEndAction: DragAction? = nil,
        endAction: Action? = nil,
        label: @escaping LabelBuilder
    ) {
        self.isPressedBinding = isPressed ?? .constant(false)
        self.pressAction = pressAction
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
    let releaseInsideAction: Action?
    let releaseOutsideAction: Action?
    let longPressDelay: TimeInterval
    let longPressAction: Action?
    let doubleTapTimeout: TimeInterval
    let doubleTapAction: Action?
    let repeatDelay: TimeInterval
    let repeatTimer: RepeatGestureTimer
    let repeatAction: Action?
    let dragStartAction: DragAction?
    let dragAction: DragAction?
    let dragEndAction: DragAction?
    let endAction: Action?
    let label: LabelBuilder

    @State
    private var isPressed = false

    @State
    private var longPressDate = Date()

    @State
    private var releaseDate = Date()

    @State
    private var repeatDate = Date()

    public var body: some View {
        label(isPressed)
            .overlay(gestureView)
            .onChange(of: isPressed) { isPressedBinding.wrappedValue = $0 }
            .accessibilityAddTraits(.isButton)
    }
}

private extension GestureButton {

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

private extension GestureButton {

    func tryHandlePress(_ value: DragGesture.Value) {
        if isPressed { return }
        isPressed = true
        pressAction?()
        dragStartAction?(value)
        tryTriggerLongPressAfterDelay()
        tryTriggerRepeatAfterDelay()
    }

    func tryHandleRelease(_ value: DragGesture.Value, in geo: GeometryProxy) {
        if !isPressed { return }
        isPressed = false
        longPressDate = Date()
        repeatDate = Date()
        repeatTimer.stop()
        releaseDate = tryTriggerDoubleTap() ? .distantPast : Date()
        dragEndAction?(value)
        if geo.contains(value.location) {
            releaseInsideAction?()
        } else {
            releaseOutsideAction?()
        }
        endAction?()
    }

    func tryTriggerLongPressAfterDelay() {
        guard let action = longPressAction else { return }
        let date = Date()
        longPressDate = date
        let delay = longPressDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard self.longPressDate == date else { return }
            action()
        }
    }

    func tryTriggerRepeatAfterDelay() {
        guard let action = repeatAction else { return }
        let date = Date()
        repeatDate = date
        let delay = repeatDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard self.repeatDate == date else { return }
            repeatTimer.start(action: action)
        }
    }

    func tryTriggerDoubleTap() -> Bool {
        let interval = Date().timeIntervalSince(releaseDate)
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

struct GestureButton_Previews: PreviewProvider {

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
                    GestureButton(
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
                }.frame(maxWidth: .infinity)
            }.padding(.horizontal)
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
            }.lineLimit(1)
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
