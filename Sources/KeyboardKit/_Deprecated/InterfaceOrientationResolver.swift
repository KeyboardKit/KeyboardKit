import Foundation

#if canImport(UIKit)
import UIKit
#endif

@available(*, deprecated, message: "This protocol is no longer used")
protocol InterfaceOrientationResolver {

    /**
     Get the current interface orientation
     */
    var interfaceOrientation: InterfaceOrientation { get }
}
