import Foundation
import UIKit


// MARK: - Public Properties

public extension KeyboardContext {
    
    @available(*, deprecated, message: "Just set keyboardType directly.")
    func changeKeyboardType(to type: KeyboardType, after delay: DispatchTimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard self.keyboardType.canBeReplaced(with: type) else { return }
            self.keyboardType = type
            completion()
        }
    }
    
    @available(iOS 12.0, *)
    @available(*, deprecated, message: "Use traitCollection.userInterfaceStyle directly.")
    var userInterfaceStyle: UIUserInterfaceStyle {
        traitCollection.userInterfaceStyle
    }
}
