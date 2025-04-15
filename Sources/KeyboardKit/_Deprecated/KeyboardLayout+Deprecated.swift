import Foundation
import SwiftUI

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
