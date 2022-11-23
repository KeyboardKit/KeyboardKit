//
//  GestureButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-16.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS)
import SwiftUI
import CoreGraphics

/**
 This button can be used to apply a bunch of gestures to the
 provided label.

 This button can also be used within a `ScrollView` and will
 not block the scrolling in any way.

 Note that the view uses an underlying `ButtonStyle` to make
 the gestures work. It can therefore not apply another style
 over it. Instead, you can instead use the `isPressed` value
 that is passed to the `label` builder, to configure how the
 button looks when it's pressed.

 Also note that the release actions may not always be called,
 since the gesture can be cancelled. If you must know when a
 gesture ends, use the `endAction`, since it's always called.

 > Important
 The view applies additional gestures on the label view when
 you specify a `dragChangedAction` or `dragEndedAction`. For
 instance, instead of just a `releaseAction` you can specify
 a `releaseInsideAction` and a `releaseOutsideAction`.
 */
@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
public struct GestureButton<Label: View>: View {

    /**
     Create a gesture button with drag gesture handling.

     This initializer uses a custom button style that can be
     used to customize the view when it's pressed.

     - Parameters:
       - isPressed: A custom, optional binding to track pressed state, by default `nil`.
       - pressAction: The action to trigger when the button is pressed, by default `nil`.
       - releaseInsideAction: The action to trigger when the button is released inside, by default `nil`.
       - releaseOutsideAction: The action to trigger when the button is released outside of its bounds, by default `nil`.
       - endAction: The action to trigger when a button gesture ends, by default `nil`.
       - longPressDelay: The time it takes for a press to count as a long press, by default ``GestureButtonDefaults/longPressDelay``.
       - longPressAction: The action to trigger when the button is long pressed, by default `nil`.
       - doubleTapTimeout: The max time between two taps for them to count as a double tap, by default ``GestureButtonDefaults/doubleTapTimeout``.
       - doubleTapAction: The action to trigger when the button is double tapped, by default `nil`.
       - repeatTimer: The repeat timer to use for the repeat action, by default ``RepeatGestureTimer/shared``.
       - repeatAction: The action to repeat while the button is being pressed, by default `nil`.
       - dragChangedAction: The action to trigger when a drag gesture changes.
       - dragEndedAction: The action to trigger when a drag gesture ends.
       - label: The button label.
     */
    init(
        isPressed: Binding<Bool>? = nil,
        pressAction: Action? = nil,
        releaseInsideAction: Action? = nil,
        releaseOutsideAction: Action? = nil,
        endAction: Action? = nil,
        longPressDelay: TimeInterval = GestureButtonDefaults.longPressDelay,
        longPressAction: Action? = nil,
        doubleTapTimeout: TimeInterval = GestureButtonDefaults.doubleTapTimeout,
        doubleTapAction: Action? = nil,
        repeatTimer: RepeatGestureTimer = .shared,
        repeatAction: Action? = nil,
        dragChangedAction: DragAction? = nil,
        dragEndedAction: DragAction? = nil,
        label: @escaping LabelBuilder
    ) {
        self.isPressedBinding = isPressed ?? .constant(false)
        self._config = State(wrappedValue: GestureConfiguration(
            state: GestureState(),
            pressAction: pressAction ?? {},
            releaseInsideAction: releaseInsideAction ?? {},
            releaseOutsideAction: releaseOutsideAction ?? {},
            endAction: endAction ?? {},
            longPressDelay: longPressDelay,
            longPressAction: longPressAction ?? {},
            doubleTapTimeout: doubleTapTimeout,
            doubleTapAction: doubleTapAction ?? {},
            repeatTimer: repeatTimer,
            repeatAction: repeatAction,
            dragChangedAction: dragChangedAction ?? { _ in },
            dragEndedAction: dragEndedAction ?? { _ in },
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

    public var body: some View {
        Button(action: config.releaseInsideAction) {
            config.label(isPressed)
                .withDragGestureActions(
                    for: self.config,
                    isPressed: $isPressed
                )
        }
        .buttonStyle(
            Style(isPressed: $isPressed, config: config)
        )
        .onChange(of: isPressed) { newValue in
            isPressedBinding.wrappedValue = newValue
        }
    }
}

/**
 This struct can be used to configure the default values for
 the ``GestureButton``.

 Just set the static properties to change the default values
 when creating a gesture button instance.
 */
@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
public struct GestureButtonDefaults {

    /// The max time between two taps for them to count as a double tap, by default `0.2`.
    public static var doubleTapTimeout = 0.2

    /// The time it takes for a press to count as a long press, by default `1.0`.
    public static var longPressDelay = 1.0
}

@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
extension GestureButton {

    class GestureState: ObservableObject {

        @Published
        var doubleTapDate = Date()
    }

    struct GestureConfiguration {
        let state: GestureState
        let pressAction: Action
        let releaseInsideAction: Action
        let releaseOutsideAction: Action
        let endAction: Action
        let longPressDelay: TimeInterval
        let longPressAction: Action
        let doubleTapTimeout: TimeInterval
        let doubleTapAction: Action
        let repeatTimer: RepeatGestureTimer
        let repeatAction: Action?
        let dragChangedAction: DragAction?
        let dragEndedAction: DragAction?
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
                        handleIsReleased()
                    }
                }
        }
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
private extension GestureButton.Style {

    func handleIsPressed() {
        isPressed.wrappedValue = true
        config.pressAction()
        tryTriggerLongPressAfterDelay(triggered: longPressDate)
    }

    func handleIsReleased() {
        if isPressed.wrappedValue {
            config.endAction()
        }
        isPressed.wrappedValue = false
    }

    func tryTriggerLongPressAfterDelay(triggered date: Date) {
        DispatchQueue.main.asyncAfter(deadline: .now() + config.longPressDelay) {
            guard date == longPressDate else { return }
            config.longPressAction()
        }
    }
}

@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
private extension View {

    typealias Action = () -> Void
    typealias DragAction = (DragGesture.Value) -> Void

    @ViewBuilder
    func withDragGestureActions<Label: View>(
        for config: GestureButton<Label>.GestureConfiguration,
        isPressed: Binding<Bool>
    ) -> some View {
        self.overlay(
            GeometryReader { geo in
                gesture(
                    TapGesture(count: 1).onEnded { _ in
                        if !isPressed.wrappedValue {
                            config.pressAction()
                        }
                        config.releaseInsideAction()
                        config.tryTriggerDoubleTap()
                        if !isPressed.wrappedValue {
                            config.endAction()
                        }
                    }
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            config.dragChangedAction?(value)
                            isPressed.wrappedValue = true
                            if config.longPressDelay > 0.6 && !config.repeatTimer.isActive {
                                config.longPressAction()
                            }
                            config.tryStartRepeatTimer()
                        }
                        .onEnded { value in
                            config.dragEndedAction?(value)
                            isPressed.wrappedValue = false
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

@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
struct ContentView_Previews: PreviewProvider {

    struct Preview: View {

        @StateObject
        var state = PreviewState()

        @State
        private var items = (1...100).map { PreviewItem(id: $0) }

        var body: some View {
            VStack(spacing: 20) {

                PreviewHeader(state: state)
                    .padding(.horizontal)

                PreviewScrollGroup(title: "Buttons") {
                    GestureButton(
                        isPressed: $state.isPressed,
                        pressAction: { state.pressCount += 1 },
                        releaseInsideAction: { state.releaseInsideCount += 1 },
                        releaseOutsideAction: { state.releaseOutsideCount += 1 },
                        endAction: { state.endCount += 1 },
                        longPressDelay: 0.8,
                        longPressAction: { state.longPressCount += 1 },
                        doubleTapAction: { state.doubleTapCount += 1 },
                        repeatAction: { state.repeatTapCount += 1 },
                        dragChangedAction: { state.dragChangedValue = $0.location },
                        dragEndedAction: { state.dragEndedValue = $0.location },
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
                .frame(width: 100)
                .opacity(isPressed ? 0.5 : 1)
                .scaleEffect(isPressed ? 0.9 : 1)
                .animation(.default, value: isPressed)
                .padding()
                // .background(Color.random())
                .cornerRadius(16)
        }
    }

    struct PreviewScrollGroup<Content: View>: View {

        let title: String
        let button: () -> Content

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0...100, id: \.self) { _ in
                            button()
                        }
                    }.padding(.horizontal)
                }
            }
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
        var endedCount = 0

        @Published
        var endCount = 0

        @Published
        var longPressCount = 0

        @Published
        var doubleTapCount = 0

        @Published
        var repeatTapCount = 0

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

        func label(_ title: String, _ value:String) -> some View {
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
