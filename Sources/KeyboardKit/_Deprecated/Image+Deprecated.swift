import SwiftUI

public extension Image {

    @available(*, deprecated, renamed: "keyboardShiftCapslockActive")
    static var keyboardShiftCapslocked: Image {
        .keyboardShiftCapslockActive
    }
}
