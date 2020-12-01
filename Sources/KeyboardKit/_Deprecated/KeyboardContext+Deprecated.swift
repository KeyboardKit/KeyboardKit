import Foundation
import UIKit


// MARK: - Public Properties

public extension KeyboardContext {
    
    /**
     The current user interface style. This is resolved from
     the `controller`s `traitCollection`.
     
     `IMPORTANT` Both this and the `colorScheme` environment
     property in SwiftUI will incorrectly be `.dark`, if the
     keyboard appearance is `.dark` in light mode. This will
     cause UI bugs in the system styles, since dark keyboard
     appearance in light mode does not look the same as dark
     mode keyboards. You can see this bug in practice if you
     run the demo app and activate the SwiftUI demo keyboard
     on a text field that requires dark keyboard appearance.
     
     Bug info (also reported to Apple in Feedback Assistant):
     https://github.com/danielsaidi/KeyboardKit/issues/107
     */
    @available(iOS 12.0, *)
    @available(*, deprecated, message: "Use traitCollection.userInterfaceStyle directly")
    var userInterfaceStyle: UIUserInterfaceStyle {
        traitCollection.userInterfaceStyle
    }
}
