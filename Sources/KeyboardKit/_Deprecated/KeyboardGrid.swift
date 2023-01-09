//
//  KeyboardGrid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "KeyboardGrid will be removed in 7.0.")
public struct KeyboardGrid<Button: View>: View {
    
    /**
     Create a keyboard grid.
     
     - Parameters:
       - actions: A list of actions to display in the grid.
       - columns: The number of columns to present in the grid.
       - spacing: The spaing between grid items.
       - buttonBuilder: An custom button builder that will be used to create a button view for each action.
     */
    public init(
        actions: [KeyboardAction],
        columns: Int,
        spacing: CGFloat = 10,
        @ViewBuilder buttonBuilder: @escaping ButtonBuilder
    ) {
        let actions = actions.evened(for: columns)
        self.actions = actions
        self.rows = actions.batched(into: columns)
        self.spacing = spacing
        self.buttonBuilder = buttonBuilder
    }

    public typealias ButtonBuilder = (KeyboardAction) -> Button
    
    private let actions: [KeyboardAction]
    private let rows: KeyboardActionRows
    private let spacing: CGFloat
    private let buttonBuilder: ButtonBuilder
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(Array(rows.enumerated()), id: \.offset) {
                self.gridRow(for: $0.element)
            }
        }
    }
}

@available(*, deprecated, message: "KeyboardGrid will be removed in 7.0.")
private extension KeyboardGrid {

    func gridRow(for row: KeyboardActions) -> some View {
        HStack(spacing: self.spacing) {
            ForEach(Array(row.enumerated()), id: \.offset) { item in
                self.buttonBuilder(item.element)
            }
        }
    }
}
