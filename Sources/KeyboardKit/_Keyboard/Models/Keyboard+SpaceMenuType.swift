//
//  Keyboard+SpaceMenuType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-02-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines spacebar context menus that can be
    /// added as leading and trailing items to the spacebar.
    ///
    /// You can apply a custom value using the view modifier
    /// ``SwiftUICore/View/keyboardSpaceContextMenu(_:edge:)``.
    enum SpaceMenuType: String, CaseIterable, Identifiable, KeyboardModel {
        
        /// Add a locale menu, if multiple locales are added.
        case locale
    }
    
    /// This view renders a space bar context menu title.
    struct SpaceContextMenuTitle: View {
        
        public init(
            _ title: String,
            alignment: Alignment,
            style: Keyboard.ButtonStyle
        ) {
            self.title = title
            self.alignment = alignment
            self.style = style
        }
        
        private let title: String
        private let alignment: Alignment
        private let style: Keyboard.ButtonStyle
        
        public var body: some View {
            Text(title)
                .font(.caption)
                .textCase(.uppercase)
                .foregroundColor(style.foregroundColor)
                .opacity(style.foregroundSecondaryOpacity ?? 0.4)
                .padding(.horizontal, 7)
                .padding(.vertical, 5)
                .frame(minWidth: 44, minHeight: 44, alignment: alignment)
        }
    }
}

public extension Keyboard.SpaceMenuType {
    
    /// The unique behavior ID.
    var id: String { rawValue }
}

public extension View {
    
    /// Apply a leading ``Keyboard/SpaceMenuType`` to space.
    func keyboardSpaceContextMenuLeading(
        _ type: Keyboard.SpaceMenuType?
    ) -> some View {
        environment(\.keyboardSpaceContextMenuLeading, type)
    }
    
    /// Apply a trailing ``Keyboard/SpaceMenuType`` to space.
    func keyboardSpaceContextMenuTrailing(
        _ type: Keyboard.SpaceMenuType?
    ) -> some View {
        environment(\.keyboardSpaceContextMenuTrailing, type)
    }
}

public extension EnvironmentValues {
    
    /// Apply a leading ``Keyboard/SpaceMenuType``.
    @Entry var keyboardSpaceContextMenuLeading: Keyboard.SpaceMenuType?
    
    /// Apply a trailing ``Keyboard/SpaceMenuType``.
    @Entry var keyboardSpaceContextMenuTrailing: Keyboard.SpaceMenuType?
}
