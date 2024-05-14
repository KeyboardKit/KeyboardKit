import Foundation
import SwiftUI

public extension KeyboardLayout {
    
    @available(*, deprecated, renamed: "hasKeyboardSwitcher(_:)")
    func hasKeyboardSwitcher(for type: Keyboard.KeyboardType) -> Bool {
        itemRows.hasKeyboardSwitcher(type)
    }
    
}

@available(*, deprecated, renamed: "KeyboardLayoutRowIdentifiable")
public typealias KeyboardLayoutRowItem = KeyboardLayoutRowIdentifiable

@available(*, deprecated, renamed: "KeyboardLayoutIdentifiable")
public typealias KeyboardLayoutRowIdentifiable = KeyboardLayoutIdentifiable

public extension KeyboardLayout.Configuration {
    
    @available(*, deprecated, renamed: "init(buttonCornerRadius:buttonInsets:rowHeight:inputToolbarHeight:)")
    init(
        buttonCornerRadius: Double,
        buttonInsets: EdgeInsets,
        rowHeight: Double,
        numberToolbarHeight: Double
    ) {
        self.init(
            buttonCornerRadius: buttonCornerRadius,
            buttonInsets: buttonInsets,
            rowHeight: rowHeight,
            inputToolbarHeight: numberToolbarHeight
        )
    }
    
    @available(*, deprecated, renamed: "inputToolbarHeight")
    var numberToolbarHeight: Double {
        get { inputToolbarHeight }
        set { inputToolbarHeight = newValue }
    }
}
