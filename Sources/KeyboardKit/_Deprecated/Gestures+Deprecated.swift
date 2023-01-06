import Foundation

#if os(iOS) || os(tvOS)
public extension SpaceCursorDragGestureHandler {

    @available(*, deprecated, renamed: "keyboardContext")
    var context: KeyboardContext { keyboardContext }
}
#endif
