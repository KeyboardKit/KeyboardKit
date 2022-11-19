//
//  GestureButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-16.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS)
import SwiftUI

/**
 This button can be used to apply a bunch of gestures to the
 provided button view, which means that you can use a single
 button for all the gestures that different keyboard actions
 need, such as taps, long presses, drag gestures etc.

 This button can also be used within a `ScrollView` and will
 not block the scrolling in any way.

 Note that the view uses an underlying `ButtonStyle` to make
 the gestures work. It can therefore not apply another style
 on top of this style. Instead, you can use the `labelStyle`
 parameter to define a configuration block.

 > Important
 The view applies many additional gestures on the label when
 you specify a `dragChangedAction` or `dragEndedAction`. The
 gestures causes a drag gesture to kick in after a while and
 cancel all other gestures. This means that some actions are
 not triggered when any drag action is specified e.g. double
 taps and long presses. Therefore, only apply these gestures
 if you need them, otherwise leave them empty.
 */
@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
public struct GestureButton<Label: View, StyledLabel: View>: View {

    /**
     Create a gesture button.

     This initializer uses a custom button style that can be
     used to customize the view when it's pressed.

     - Parameters:
       - isPressed: A custom, optional binding to track pressed state, by default `nil`.
       - pressAction: The action to trigger when the button is pressed, by default `nil`.
       - releaseAction: The action to trigger when the button is released, by default `nil`.
       - endAction: The action to trigger when a button gesture ends, by default `nil`.
       - longPressTime: The time it takes for a press to cound as a long press, by default `1`.
       - longPressAction: The action to trigger when the button is long pressed, by default `nil`.
       - doubleTapTime: The max interval for two taps to count as a double tap, by default `0.5`.
       - doubleTapAction: The action to trigger when the button is double tapped, by default `nil`.
       - repeatAction: The action to repeat while the button is being pressed, by default `nil`.
       - dragChangedAction: The action to trigger when a drag gesture changes.
       - dragEndedAction: The action to trigger when a drag gesture ends.
       - label: The button label.
       - labelStyle: The style to apply to the button label.
     */
    init(
        isPressed: Binding<Bool>? = nil,
        pressAction: Action? = nil,
        releaseAction: Action? = nil,
        endAction: Action? = nil,
        longPressTime: TimeInterval = 1,
        longPressAction: Action? = nil,
        doubleTapTime: TimeInterval = 0.5,
        doubleTapAction: Action? = nil,
        repeatAction: Action? = nil,
        dragChangedAction: DragAction? = nil,
        dragEndedAction: DragAction? = nil,
        label: @escaping LabelBuilder,
        labelStyle: @escaping StyledLabelBuilder
    ) {
        self.style = Style(
            isPressed: isPressed ?? .constant(false),
            pressAction: pressAction ?? {},
            endAction: endAction ?? {},
            longPressTime: longPressTime,
            longPressAction: longPressAction ?? {},
            doubleTapTime: doubleTapTime,
            doubleTapAction: doubleTapAction ?? {},
            repeatAction: repeatAction,
            labelStyle: labelStyle
        )

        self.pressAction = pressAction ?? {}
        self.releaseAction = releaseAction ?? {}
        self.endAction = endAction ?? {}
        self.doubleTapAction = doubleTapAction ?? {}
        self.dragChangedAction = dragChangedAction
        self.dragEndedAction = dragEndedAction
        self.label = label
    }

    /**
     Create a gesture button.

     This initializer uses a default button style that makes
     no changes to the view when it's pressed.

     - Parameters:
       - isPressed: A custom, optional binding to track pressed state, by default `nil`.
       - pressAction: The action to trigger when the button is pressed, by default `nil`.
       - releaseAction: The action to trigger when the button is released, by default `nil`.
       - endAction: The action to trigger when a button gesture ends, by default `nil`.
       - longPressTime: The time it takes for a press to cound as a long press, by default `1`.
       - longPressAction: The action to trigger when the button is long pressed, by default `nil`.
       - doubleTapTime: The max interval for two taps to count as a double tap, by default `0.5`.
       - doubleTapAction: The action to trigger when the button is double tapped, by default `nil`.
       - repeatAction: The action to repeat while the button is being pressed, by default `nil`.
       - dragChangedAction: The action to trigger when a drag gesture changes.
       - dragEndedAction: The action to trigger when a drag gesture ends.
       - label: The button label.
     */
    init(
        isPressed: Binding<Bool>? = nil,
        pressAction: Action? = nil,
        releaseAction: Action? = nil,
        endAction: Action? = nil,
        longPressTime: TimeInterval = 1,
        longPressAction: Action? = nil,
        doubleTapTime: TimeInterval = 0.5,
        doubleTapAction: Action? = nil,
        repeatAction: Action? = nil,
        dragChangedAction: DragAction? = nil,
        dragEndedAction: DragAction? = nil,
        label: @escaping LabelBuilder
    ) where StyledLabel == GestureButton.Style.Configuration.Label {
        self.init(
            isPressed: isPressed,
            pressAction: pressAction,
            releaseAction: releaseAction,
            endAction: endAction,
            longPressTime: longPressTime,
            longPressAction: longPressAction,
            doubleTapTime: doubleTapTime,
            doubleTapAction: doubleTapAction,
            repeatAction: repeatAction,
            dragChangedAction: dragChangedAction,
            dragEndedAction: dragEndedAction,
            label: label,
            labelStyle: { $0.label }
        )
    }

    public typealias Action = () -> Void
    public typealias DragAction = (DragGesture.Value) -> Void
    public typealias LabelBuilder = () -> Label
    public typealias StyledLabelBuilder = (GestureButton.Style.Configuration) -> StyledLabel

    private var label: LabelBuilder
    private var style: Style

    private var pressAction: Action
    private var releaseAction: Action
    private var endAction: Action
    private var doubleTapAction: Action
    private var dragChangedAction: DragAction?
    private var dragEndedAction: DragAction?

    public var body: some View {
        Button(action: releaseAction) {
            label()
                .withOptionalDragGestureActions(
                    pressAction: pressAction,
                    releaseAction: releaseAction,
                    endAction: endAction,
                    dragChangedAction: dragChangedAction,
                    dragEndedAction: dragEndedAction)
        }.buttonStyle(style)
    }
}

private extension View {

    typealias Action = () -> Void
    typealias DragAction = (DragGesture.Value) -> Void

    @ViewBuilder
    func withOptionalDragGestureActions(
        pressAction: @escaping Action,
        releaseAction: @escaping Action,
        endAction: @escaping Action,
        dragChangedAction: DragAction?,
        dragEndedAction: DragAction?
    ) -> some View {
        if dragChangedAction == nil && dragEndedAction == nil {
            self
        } else {
            self.onTapGesture {
                pressAction()
                releaseAction()
                endAction()
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged(dragChangedAction ?? { _ in })
                    .onEnded(dragEndedAction ?? { _ in })
            )
        }
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
public extension GestureButton {

    struct Style: ButtonStyle {

        init(
            isPressed: Binding<Bool>,
            pressAction: @escaping Action,
            endAction: @escaping Action,
            longPressTime: TimeInterval,
            longPressAction: @escaping Action,
            doubleTapTime: TimeInterval,
            doubleTapAction: @escaping Action,
            repeatAction: Action?,
            labelStyle: @escaping StyledLabelBuilder
        ) {
            self.isPressedValue = isPressed
            self.doubleTapTime = doubleTapTime
            self.longPressTime = longPressTime
            self.pressAction = pressAction
            self.endAction = endAction
            self.longPressAction = longPressAction
            self.doubleTapAction = doubleTapAction
            self.repeatAction = repeatAction
            self.labelStyle = labelStyle
        }

        public typealias Action = () -> Void

        private var isPressedValue: Binding<Bool>
        private var doubleTapTime: TimeInterval
        private var longPressTime: TimeInterval

        private var pressAction: Action
        private var endAction: Action
        private var longPressAction: Action
        private var doubleTapAction: Action
        private var repeatAction: Action?
        private var labelStyle: StyledLabelBuilder

        @State
        var doubleTapDate = Date()

        @State
        var longPressDate = Date()

        public func makeBody(configuration: Configuration) -> some View {
            labelStyle(configuration)
                .onChange(of: configuration.isPressed) { isPressed in
                    longPressDate = Date()
                    if isPressed {
                        isPressedValue.wrappedValue = true
                        pressAction()
                        doubleTapDate = tryTriggerDoubleTap() ? .distantPast : Date()
                        tryStartRepeatTimer()
                        tryTriggerLongPressAfterDelay(triggered: longPressDate)
                    } else {
                        isPressedValue.wrappedValue = false
                        endAction()
                        tryStopRepeatTimer()
                    }
                }
        }
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
private extension GestureButton.Style {

    func tryStartRepeatTimer() {
        guard let action = repeatAction else { return }
        RepeatGestureTimer.shared.start(action: action)
    }

    func tryStopRepeatTimer() {
        if repeatAction == nil { return }
        RepeatGestureTimer.shared.stop()
    }

    func tryTriggerDoubleTap() -> Bool {
        let interval = Date().timeIntervalSince(doubleTapDate)
        guard interval < doubleTapTime else { return false }
        doubleTapAction()
        return true
    }

    func tryTriggerLongPressAfterDelay(triggered date: Date) {
        DispatchQueue.main.asyncAfter(deadline: .now() + longPressTime) {
            guard date == longPressDate else { return }
            longPressAction()
        }
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
struct ContentView_Previews: PreviewProvider {

    struct Preview: View {

        @State
        private var isPressed = false

        @State
        private var pressCount = 0

        @State
        private var longPressCount = 0

        @State
        private var releaseCount = 0

        @State
        private var endCount = 0

        @State
        private var doubleTapCount = 0

        @State
        private var repeatCount = 0

        @State
        private var dragChangedValue = CGPoint.zero

        @State
        private var dragEndedValue = CGPoint.zero

        var body: some View {
            VStack {
                VStack {
                    Text("Is pressed: \(isPressed ? "YES" : "NO")")
                        .padding(.bottom)
                    Text("\(pressCount) presses")
                    Text("\(releaseCount) releases")
                    Text("\(endCount) ended gestures")
                    Text("\(longPressCount) long presses")
                    Text("\(doubleTapCount) double taps")
                    Text("\(repeatCount) repeats")
                    Text("\(dragChangedValue.debugDescription) drag changed")
                        .lineLimit(1)
                    Text("\(dragEndedValue.debugDescription) drag ended")
                        .lineLimit(1)
                }.font(.headline)


                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0...100, id: \.self) { _ in
                            GestureButton(
                                isPressed: $isPressed,
                                pressAction: { pressCount += 1 },
                                releaseAction: { releaseCount += 1 },
                                endAction: { endCount += 1 },
                                longPressAction: { longPressCount += 1 },
                                doubleTapAction: { doubleTapCount += 1 },
                                repeatAction: { repeatCount += 1 },
                                // dragChangedAction: { dragChangedValue = $0.location },
                                // dragEndedAction: { dragEndedValue = $0.location },
                                label: {
                                    Color.red
                                        .cornerRadius(10)
                                        .frame(width: 100)
                                },
                                labelStyle: { $0.label
                                        .opacity($0.isPressed ? 0.5 : 1)
                                        .scaleEffect($0.isPressed ? 0.9 : 1)
                                        .animation(.default, value: $0.isPressed)
                                })
                        }
                    }
                    .padding()
                }
            }
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
