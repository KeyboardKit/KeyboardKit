import Foundation

public extension KeyboardLayout {
    
    @available(*, deprecated, message: "Use the itemRows initializer instead.")
    convenience init(items: KeyboardLayoutItemRows) {
        self.init(itemRows: items)
    }
    
    var items: KeyboardLayoutItemRows { itemRows }
}
