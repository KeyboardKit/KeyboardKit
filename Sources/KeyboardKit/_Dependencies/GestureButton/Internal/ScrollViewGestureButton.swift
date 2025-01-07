//
//  ScrollViewGestureButton.swift
//  GestureButton
//
//  Created by Daniel Saidi on 2022-11-16.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
import SwiftUI

/// This button can be used to trigger gesture-based actions
/// in a way that works in a `ScrollView` before iOS 18.
///
/// This view is no longer needed from iOS 18, and will thus
/// be in this unpolished state until it can be removed.
struct ScrollViewGestureButton<Label: View>: View {

    init(
        isPressed: Binding<Bool>? = nil,
        pressAction: Action? = nil,
        releaseInsideAction: Action? = nil,
        releaseOutsideAction: Action? = nil,
        longPressDelay: TimeInterval? = nil,
        longPressAction: Action? = nil,
        doubleTapTimeout: TimeInterval? = nil,
        doubleTapAction: Action? = nil,
        repeatDelay: TimeInterval? = nil,
        repeatAction: Action? = nil,
        repeatTimer: GestureButtonTimer? = nil,
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
            longPressDelay: longPressDelay ?? GestureButtonDefaults.longPressDelay,
            longPressAction: longPressAction ?? {},
            doubleTapTimeout: doubleTapTimeout ?? GestureButtonDefaults.doubleTapTimeout,
            doubleTapAction: doubleTapAction ?? {},
            repeatDelay: repeatDelay ?? GestureButtonDefaults.repeatDelay,
            repeatTimer: repeatTimer ?? .init(),
            repeatAction: repeatAction,
            dragStartAction: dragStartAction,
            dragAction: dragAction,
            dragEndAction: dragEndAction,
            endAction: endAction ?? {},
            label: label
        ))
    }

    typealias Action = () -> Void
    typealias DragAction = (DragGesture.Value) -> Void
    typealias LabelBuilder = (_ isPressed: Bool) -> Label

    var isPressedBinding: Binding<Bool>

    @State
    var config: GestureConfiguration

    @State
    private var isPressed = false

    @State
    private var isPressedByGesture = false

    var body: some View {
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
        .accessibilityAddTraits(.isButton)
    }
}

extension ScrollViewGestureButton {

    class GestureState: ObservableObject {

        @Published
        var doubleTapDate = Date()
    }

    @MainActor
    struct GestureConfiguration {
        let state: GestureState
        let pressAction: Action
        let releaseInsideAction: Action
        let releaseOutsideAction: Action
        let longPressDelay: TimeInterval
        let longPressAction: Action
        let doubleTapTimeout: TimeInterval
        let doubleTapAction: Action
        let repeatDelay: TimeInterval
        let repeatTimer: GestureButtonTimer
        let repeatAction: Action?
        let dragStartAction: DragAction?
        let dragAction: DragAction?
        let dragEndAction: DragAction?
        let endAction: Action
        let label: LabelBuilder

        func handleRepeatAction() {
            guard let repeatAction else { return }
            repeatAction()
        }

        func tryStartRepeatTimer() {
            if repeatTimer.isActive { return }
            repeatTimer.start {
                Task { await handleRepeatAction() }
            }
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
        var gestureDate = Date()

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .onChange(of: configuration.isPressed) { isPressed in
                    gestureDate = Date()
                    if isPressed {
                        handleIsPressed()
                    } else {
                        handleIsEnded()
                    }
                }
        }
    }
}

private extension ScrollViewGestureButton.Style {

    func handleIsPressed() {
        isPressed.wrappedValue = true
        config.pressAction()
        tryTriggerLongPressAfterDelay(triggered: gestureDate)
        tryTriggerRepeatAfterDelay(triggered: gestureDate)
    }

    func handleIsEnded() {
        if isPressedByGesture.wrappedValue { return }
        isPressed.wrappedValue = false
        config.endAction()
        config.tryStopRepeatTimer()
    }

    func tryTriggerLongPressAfterDelay(triggered date: Date) {
        DispatchQueue.main.asyncAfter(deadline: .now() + config.longPressDelay) {
            guard date == gestureDate else { return }
            config.longPressAction()
        }
    }

    func tryTriggerRepeatAfterDelay(triggered date: Date) {
        DispatchQueue.main.asyncAfter(deadline: .now() + config.repeatDelay) {
            guard date == gestureDate else { return }
            config.tryStartRepeatTimer()
        }
    }
}

private extension View {

    typealias Action = () -> Void
    typealias DragAction = (DragGesture.Value) -> Void

    @ViewBuilder
    func withDragGestureActions<Label: View>(
        for config: ScrollViewGestureButton<Label>.GestureConfiguration,
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
                        config.tryStopRepeatTimer()
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

#Preview {

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
                    ScrollViewGestureButton(
                        isPressed: $state.isPressed,
                        pressAction: { state.pressCount += 1 },
                        releaseInsideAction: { state.releaseInsideCount += 1 },
                        releaseOutsideAction: { state.releaseOutsideCount += 1 },
                        longPressDelay: 0.8,
                        longPressAction: { state.longPressCount += 1 },
                        doubleTapAction: { state.doubleTapCount += 1 },
                        repeatAction: { state.repeatTapCount += 1 },
                        dragStartAction: { state.dragStartValue = $0.location },
                        dragAction: { state.dragChangeValue = $0.location },
                        dragEndAction: { state.dragEndValue = $0.location },
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
                .frame(width: 100)
                .opacity(isPressed ? 0.5 : 1)
                .scaleEffect(isPressed ? 0.9 : 1)
                .animation(.default, value: isPressed)
                .padding()
                .background(color.opacity(0.1))
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
        var endCount = 0

        @Published
        var longPressCount = 0

        @Published
        var doubleTapCount = 0

        @Published
        var repeatTapCount = 0

        @Published
        var dragStartValue = CGPoint.zero

        @Published
        var dragChangeValue = CGPoint.zero

        @Published
        var dragEndValue = CGPoint.zero
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
                    label("Drag start", state.dragStartValue)
                    label("Drag change", state.dragChangeValue)
                    label("Drag end", state.dragEndValue)
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

    return Preview()
}
#endif
