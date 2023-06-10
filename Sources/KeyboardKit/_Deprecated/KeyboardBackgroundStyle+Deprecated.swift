import SwiftUI

public extension KeyboardBackgroundStyle {

    @available(*, deprecated, message: "You no longer have to specify the type parameter name")
    init(type: KeyboardBackgroundType) {
        self.backgroundType = type
        self.backgroundColor = nil
        self.backgroundGradient = nil
        self.imageData = nil
        self.overlayColor = nil
        self.overlayGradient = nil
    }
}
