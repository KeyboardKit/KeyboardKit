//
//  KeyboardGrid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 A `KeyboardGrid` can be used to list actions in a grid with
 a certain number of `columns`.
 
 The grid supports a custom item `spacing` and will fill the
 provided `actions` with enough `none` actions to evenly fit
 the grid, given the number of `columns`. `buttonBuilder` is
 then used to generate a button for each action.
 
 The grid doesn't modify the buttons you provide it with. If
 you want your buttons to share the available width, you can
 apply `.frame(maxWidth: .infinity)` to each button.
 */
public struct KeyboardGrid<Button: View>: View {
    
    public init(
        actions: [KeyboardAction],
        columns: Int,
        spacing: CGFloat = 10,
        @ViewBuilder buttonBuilder: @escaping (KeyboardAction) -> Button) {
        let actions = actions.evened(for: columns)
        self.actions = actions
        self.rows = actions.batched(withBatchSize: columns)
        self.spacing = spacing
        self.buttonBuilder = buttonBuilder
    }
    
    private let actions: [KeyboardAction]
    private let rows: KeyboardActionRows
    private let spacing: CGFloat
    private let buttonBuilder: (KeyboardAction) -> Button
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(Array(rows.enumerated()), id: \.offset) {
                self.gridRow(for: $0.element)
            }
        }
    }
}

private extension KeyboardGrid {

    func gridRow(for row: KeyboardActionRow) -> some View {
        HStack(spacing: self.spacing) {
            ForEach(Array(row.enumerated()), id: \.offset) { item in
                self.buttonBuilder(item.element)
            }
        }
    }
}

struct KeyboardGrid_Previews: PreviewProvider {
    
    static let image = KeyboardAction.image(description: "", keyboardImageName: "david", imageName: "david")
    
    static var actions: [KeyboardAction] = [
        image, image, image, image, image, image,
        image, image, image, image, image, image,
        image, image, image, image, image, image,
        image, image, image, image, image, image,
        image, image, image, image, image, image,
        image, image, image
    ]

    static var previews: some View {
        KeyboardGrid(actions: actions, columns: 6) { _ in
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
        }
    }
}
