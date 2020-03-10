//
//  KeyboardActionGrid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 A `KeyboardActionGrid` can be used to list keyboard actions
 in a grid with a certain number of `columns`.
 
 The grid supports a custom grid `padding` and item `spacing`
 and will even out the provided `actions` array with actions
 so that the array has enough tems to evenly fit the grid.
 
 The provided `buttonBuilder` will be called for each action
 and will be used to provide the grid with any view for each
 action. This makes the grid very customizable.
 */
@available(iOS 13.0, *)
public struct KeyboardActionGrid<Button: View>: View {
    
    public init(
        actions: [KeyboardAction],
        columns: Int,
        padding: CGFloat = 10,
        spacing: CGFloat = 10,
        @ViewBuilder buttonBuilder: @escaping (KeyboardAction) -> Button) {
        let actions = actions.evened(for: columns)
        self.rows = actions.batched(withBatchSize: columns)
        self.padding = padding
        self.spacing = spacing
        self.buttonBuilder = buttonBuilder
    }
    
    private let rows: KeyboardActionRows
    private let padding: CGFloat
    private let spacing: CGFloat
    private let buttonBuilder: (KeyboardAction) -> Button
    
    public var body: some View {
        ScrollView {
            VStack(spacing: spacing) {
                ForEach(Array(rows.enumerated()), id: \.offset) {
                    self.gridRow(for: $0.element)
                }
            }.padding(padding)
        }
    }
}

@available(iOS 13.0, *)
private extension KeyboardActionGrid {

    func gridRow(for row: KeyboardActionRow) -> some View {
        KeyboardActionGridRow(spacing: self.spacing) {
            ForEach(Array(row.enumerated()), id: \.offset) { item in
                self.buttonBuilder(item.element)
            }
        }
    }
}

@available(iOS 13.0, *)
struct KeyboardActionGrid_Previews: PreviewProvider {
    
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
        KeyboardActionGrid(actions: actions, columns: 6) { _ in
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
        }
    }
}
