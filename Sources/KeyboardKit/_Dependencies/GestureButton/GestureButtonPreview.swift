//
//  GestureButtonPreview.swift
//  GestureButton
//
//  Created by Daniel Saidi on 2024-09-01.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct GestureButtonPreview {
    
    struct Content<Content: View>: View {
        
        @ObservedObject
        var state: GestureButtonPreview.State
        
        @ViewBuilder
        var content: () -> Content
        
        var body: some View {
            VStack(spacing: 20) {
                GestureButtonPreview.Header(state: state)
                    .padding(.horizontal)

                ScrollView(.horizontal) {
                    HStack(spacing: 25) {
                        ForEach(0...10, id: \.self) { _ in
                            content()
                                .frame(width: 50)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    struct Item: View {
        
        var isPressed: Bool
        
        var color: Color {
            isPressed ? .green : .red
        }
        
        var body: some View {
            color
                .clipShape(.rect(cornerRadius: 10))
                .opacity(isPressed ? 0.5 : 1)
                .scaleEffect(isPressed ? 0.9 : 1)
                .animation(.default, value: isPressed)
        }
    }
    
    struct Header: View {
        
        @ObservedObject
        var state: GestureButtonPreview.State

        var body: some View {
            VStack(alignment: .leading) {
                label("Pressed", state.isPressed ? "YES" : "NO")
                label("Presses", state.pressCount)
                label("Releases (Inside)", state.releaseInsideCount)
                label("Releases (Outside)", state.releaseOutsideCount)
                label("Ended", state.endCount)
                label("Long presses", state.longPressCount)
                label("Double taps", state.doubleTapCount)
                label("Repeats", state.repeatCount)
                label("Drag start", state.dragStartValue)
                label("Drag changed", state.dragChangedValue)
                label("Drag end", state.dragEndValue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).stroke(.blue, lineWidth: 3))
        }
        
        func label(_ title: String, _ point: CGPoint) -> some View {
            label(title, "\(point.x.rounded()), \(point.y.rounded())")
        }
        
        func label(_ title: String, _ value: Int) -> some View {
            label(title, "\(value)")
        }
        
        func label(_ title: String, _ value: String) -> some View {
            HStack {
                Text("\(title):")
                Text("\(value)").bold()
            }
            .lineLimit(1)
        }
    }
    
    class State: ObservableObject {
        
        @Published var isPressed = false
        @Published var pressCount = 0
        @Published var releaseInsideCount = 0
        @Published var releaseOutsideCount = 0
        @Published var endCount = 0
        @Published var longPressCount = 0
        @Published var doubleTapCount = 0
        @Published var repeatCount = 0
        @Published var dragStartValue = CGPoint.zero
        @Published var dragChangedValue = CGPoint.zero
        @Published var dragEndValue = CGPoint.zero
    }
}
