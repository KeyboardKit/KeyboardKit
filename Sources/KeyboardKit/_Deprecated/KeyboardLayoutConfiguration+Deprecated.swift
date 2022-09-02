#if os(iOS)
import Foundation
import UIKit

public extension KeyboardLayoutConfiguration {

    /**
     The standard config for the provided idiom and screen.
     */
    @available(*, deprecated, message: "Use standard(forDevice:screenSize:oriantation) instead")
    static func standard(
        forIdiom idiom: UIUserInterfaceIdiom,
        screenSize size: CGSize,
        orientation: UIInterfaceOrientation) -> KeyboardLayoutConfiguration {
        switch idiom {
        case .pad: return standardPad(forScreenSize: size, orientation: orientation)
        default: return standardPhone(forScreenSize: size, orientation: orientation)
        }
    }
}
#endif
