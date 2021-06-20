import SwiftUI

public extension Image {
    
    @available(*, deprecated, renamed: "keyboardLeft")
    static var moveCursorLeft: Image { .keyboardLeft }
    
    @available(*, deprecated, renamed: "keyboardRight")
    static var moveCursorRight: Image { .keyboardRight }
    
    @available(*, deprecated, renamed: "keyboardSettings")
    static var settings: Image { .keyboardSettings }
}
