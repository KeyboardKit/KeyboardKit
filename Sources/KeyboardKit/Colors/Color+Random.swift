//
//  Color+Random.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-08-17.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Color {

    /// Generate a random color.
    ///
    /// - Parameters:
    ///   - range: The random color range, by default `0...1`.
    ///   - randomOpacity: Whether or not to randomize opacity as well, by default `false`.
    static func random(
        in range: ClosedRange<Double> = 0...1,
        randomOpacity: Bool = false
    ) -> Color {
        Color(
            red: .random(in: range),
            green: .random(in: range),
            blue: .random(in: range),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}


#Preview {

    func preview(for color: Color) -> some View {
        color.cornerRadius(10)
    }

    return VStack {
        preview(for: .random())
        preview(for: .random(randomOpacity: true))
        preview(for: .random(in: 0...0.3))
        preview(for: .random(in: 0...0.3, randomOpacity: true))
    }
    .padding()
}
