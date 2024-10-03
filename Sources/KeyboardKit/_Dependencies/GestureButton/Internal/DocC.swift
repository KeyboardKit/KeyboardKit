import SwiftUI

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
struct ContentView: View {

    @State private var isPressed = false
    
    var body: some View {
        GestureButton(
            isPressed: $isPressed,
            pressAction: { print("Pressed") },
            releaseInsideAction: { print("Released Inside") },
            releaseOutsideAction: { print("Released Outside") },
            longPressAction: { print("Long Pressed") },
            doubleTapAction: { print("Double Tapped") },
            repeatAction: { print("Repeating Action") },
            dragStartAction: { value in print("Drag Started at \(value)") },
            dragAction: { value in print("Drag \(value)") },
            dragEndAction: { value in print("Drag Ended at \(value)") },
            endAction: { print("Gesture Ended") },
            label: { isPressed in
                isPressed ? Color.green : Color.gray // You can use any button content view.
            }
        )
    }
}

struct ContentView2: View {

    @StateObject private var scrollState = GestureButtonScrollState()

    var body: some View {
        ScrollView(.horizontal) {
            GestureButton(
                scrollState: scrollState,
                pressAction: { print("Pressed") },
                label: { _ in
                    Color.yellow // You can use any button content view.
                }
            )
        }
        .scrollGestureState(scrollState)
    }
}
#endif
