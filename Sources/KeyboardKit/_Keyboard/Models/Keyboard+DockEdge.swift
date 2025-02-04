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
    enum DockEdge: String, Identifiable, CaseIterable, KeyboardModel {
        
        /// Dock the keyboard to the leading edge.
        case leading
        
        /// Dock the keyboard to the trailing edge.
        case trailing
    }
}

public extension Keyboard.DockEdge {
    
    /// The unique edge ID.
    var id: String { rawValue }
    
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

    /// Apply a ``Keyboard/DockEdge`` value.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/keyboardDockEdge``.
    func keyboardDockEdge(
        _ value: Keyboard.DockEdge?
    ) -> some View {
        self.environment(\.keyboardDockEdge, value)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Keyboard/DockEdge`` value.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/keyboardDockEdge``.
    @Entry var keyboardDockEdge: Keyboard.DockEdge?
}
