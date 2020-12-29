import Foundation
import UIKit


// MARK: - Public Properties

public extension KeyboardContext {
    
    @available(iOS 12.0, *)
    @available(*, deprecated, message: "Use traitCollection.userInterfaceStyle directly")
    var userInterfaceStyle: UIUserInterfaceStyle {
        traitCollection.userInterfaceStyle
    }
}
