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
 provided `actions` array with enough `.none` actions, so it
 has enough items to evenly fit the grid. The `buttonBuilder`
 will be used to create a button for each action.
 
 The grid doesn't modify the buttons you provide it with. If
 you want your buttons to share the available width, you can
 apply `.frame(maxWidth: .infinity)` to each button.
 */
@available(iOS 13.0, *)
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
    
    public let actions: [KeyboardAction]
    public let rows: KeyboardActionRows
    public let spacing: CGFloat
    public let buttonBuilder: (KeyboardAction) -> Button
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(Array(rows.enumerated()), id: \.offset) {
                self.gridRow(for: $0.element)
            }
        }
    }
}

@available(iOS 13.0, *)
private extension KeyboardGrid {

    func gridRow(for row: KeyboardActionRow) -> some View {
        KeyboardGridRow(spacing: self.spacing) {
            ForEach(Array(row.enumerated()), id: \.offset) { item in
                self.buttonBuilder(item.element)
            }
        }
    }
}

@available(iOS 13.0, *)
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
