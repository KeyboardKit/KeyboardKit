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
 
 The grid supports custom `padding` and `spacing` and can be
 configured to even out the actions to fit the column count.
 
 The provided `buttonBuilder` will be called for each action
 and can provide the grid with any view for each action.
 */
@available(iOS 13.0, *)
public struct KeyboardActionGrid<Button: View>: View {
    
    public init(
        actions: [KeyboardAction],
        columns: Int,
        evenColumns: Bool = true,
        padding: CGFloat = 10,
        spacing: CGFloat = 10,
        @ViewBuilder buttonBuilder: @escaping (KeyboardAction) -> Button) {
        let actions = evenColumns ? actions.evened(for: columns) : actions
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
