import Foundation

#if canImport(UIKit)
import UIKit
#endif

@available(*, deprecated, message: "This protocol is no longer used")
protocol InterfaceOrientationResolver {

    var interfaceOrientation: InterfaceOrientation { get }
}
