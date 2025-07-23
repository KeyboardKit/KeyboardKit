import Foundation
import SwiftUI

@available(*, deprecated, renamed: "KeyboardLayout.InputSet")
public typealias InputSet = KeyboardLayout.InputSet

public extension KeyboardLayout {
    
    @available(*, deprecated, renamed: "init(itemRows:ipadProLayout:idealItemHeight:idealItemInsets:inputToolbarInputSet:)")
    init(
        itemRows: ItemRows,
        iPadProLayout: Bool = false,
        idealItemHeight: Double? = nil,
        idealItemInsets: EdgeInsets? = nil,
        numberInputToolbarInputSet: InputSet
    ) {
        self.init(
            itemRows: itemRows,
            iPadProLayout: iPadProLayout,
            idealItemHeight: idealItemHeight,
            idealItemInsets: idealItemInsets,
            inputToolbarInputSet: numberInputToolbarInputSet
        )
    }

    @available(*, deprecated, renamed: "inputToolbarInputSet")
    var numberInputToolbarInputSet: InputSet? {
        get { inputToolbarInputSet }
        set { inputToolbarInputSet = newValue }
    }
}

public extension KeyboardLayout {
    
    @available(*, deprecated, renamed: "DeviceConfiguration")
    typealias Configuration = DeviceConfiguration
}

public extension KeyboardLayout {

    @available(*, deprecated, renamed: "isIpadProLayout")
    var ipadProLayout: Bool {
        get { isIpadProLayout }
        set { isIpadProLayout = newValue }
    }
}
