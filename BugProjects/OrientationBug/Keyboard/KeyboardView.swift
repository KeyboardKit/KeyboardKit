//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-09-25.
//

import SwiftUI

struct KeyboardView: View {
    
    @State private var isCollapsed = false
        
    var body: some View {
        stack
    }
}

extension KeyboardView {
    
    var grid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50, maximum: 100))]) {
            ForEach(0...30, id: \.self) { _ in
                Color.random.frame(maxHeight: .infinity)
            }
        }.frame(height: 300)
    }
    
    var stack: some View {
        VStack {
            ForEach(0...3, id: \.self) { _ in
                HStack {
                    ForEach(0...3, id: \.self) { _ in
                        Color.random
                            .frame(height: isCollapsed ? 50 : 100)
                            .onTapGesture { isCollapsed.toggle() }
                    }
                }
            }
        }//.frame(height: 300)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
