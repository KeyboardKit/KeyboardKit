import SwiftUI

public extension KeyboardBackgroundStyle {

    @available(*, deprecated, message: "You no longer have to specify the type parameter name")
    init(type: KeyboardBackgroundType) {
        self.backgroundType = type
    }
}
