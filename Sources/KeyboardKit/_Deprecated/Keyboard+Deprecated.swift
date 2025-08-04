import Foundation
import SwiftUI

public extension Keyboard {
    
    @available(*, deprecated, renamed: "Keyboard.Diacritic")
    typealias Accent = Diacritic
    
    @available(*, deprecated, renamed: "Keyboard.DiacriticInsertionResult")
    typealias DiacriticResult = DiacriticInsertionResult
    
    @available(*, deprecated, renamed: "Keyboard.SpaceMenuType")
    typealias SpaceContextMenu = SpaceMenuType
}

public extension Keyboard.ButtonStyle {

    @available(*, deprecated, renamed: "standard(for:action:isPressed:)")
    static func standard(
        for action: KeyboardAction,
        context: KeyboardContext,
        isPressed: Bool
    ) -> Keyboard.ButtonStyle {
        action.standardButtonStyle(for: context, isPressed: isPressed)
    }
}

public extension Keyboard.DiacriticInsertionResult {
    
    @available(*, deprecated, renamed: "deleteBackwardsCount")
    var removeLast: Bool { deleteBackwardsCount == 1 }
    
    @available(*, deprecated, renamed: "textInsertion")
    var insert: String { textInsertion }
}

public extension Keyboard.InputToolbarDisplayMode {
    
    @available(*, deprecated, renamed: "none")
    static var hidden: Self { .none }
    
    @available(*, deprecated, renamed: "characters")
    static func inputs(_ inputs: String) -> Self {
        .characters(inputs)
    }
}

public extension Keyboard.SpaceLongPressBehavior {
    
    @available(*, deprecated, message: "Use Keyboard.SpaceContextMenu instead.")
    static var moveInputCursorWithLocaleSwitcher: Self { .moveInputCursor }
    
    @available(*, deprecated, message: "Use Keyboard.SpaceContextMenu instead.")
    var shouldAddTrailingLocaleContextMenu: Bool {
        switch self {
        case .moveInputCursor: false
        case .openLocaleContextMenu: false
        }
    }
}

public extension KeyboardContext {

    @available(*, deprecated, message: "Use `settings.spaceLongPressBehavior` instead.")
    var spaceLongPressBehavior: Keyboard.SpaceLongPressBehavior {
        get { settings.spaceLongPressBehavior }
        set { settings.spaceLongPressBehavior = newValue }
    }
}

public extension View {

    @available(*, deprecated, message: "Use keyboardSpaceContextMenuLeading and keyboardSpaceContextMenuTrailing instead.")
    func keyboardSpaceContextMenu(
        _ type: Keyboard.SpaceMenuType?,
        edge: HorizontalEdge = .trailing
    ) -> some View {
        switch edge {
        case .leading: environment(\.keyboardSpaceContextMenuLeading, type)
        case .trailing: environment(\.keyboardSpaceContextMenuTrailing, type)
        }
    }
}
