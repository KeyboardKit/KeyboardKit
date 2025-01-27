//
//  Keyboard+DockEdge.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-01-22.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines supported keyboard dock edges.
    ///
    /// You can apply a custom value using the view modifier
    /// ``SwiftUICore/View/keyboardDockEdge(_:)``.
    enum DockEdge: String, CaseIterable, KeyboardModel {
        case leading, trailing
    }
}

public extension Keyboard.DockEdge {
    
    /// The corresponding keyboard alignment.
    var alignment: Alignment {
        switch self {
        case .leading: .leading
        case .trailing: .trailing
        }
    }
    
    /// The corresponding horizontal edge.
    var edge: HorizontalEdge {
        switch self {
        case .leading: .leading
        case .trailing: .trailing
        }
    }
}

public extension View {

    /// Apply an ``Keyboard/DockEdge``.
    func keyboardDockEdge(
        _ edge: Keyboard.DockEdge?
    ) -> some View {
        self.environment(\.keyboardDockEdge, edge)
    }
}

public extension EnvironmentValues {

    /// Apply an ``Keyboard/DockEdge``.
    @Entry var keyboardDockEdge: Keyboard.DockEdge?
}
