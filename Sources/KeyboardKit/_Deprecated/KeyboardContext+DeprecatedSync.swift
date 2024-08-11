import Foundation
import SwiftUI

public extension KeyboardContext {

    /// DEPRECATED!
    ///
    /// > Warning: Settings are moved to ``KeyboardContext``.
    /// This will be removed in KeyboardKit 9.0.
    func sync(with settings: KeyboardSettings) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: settings)
        }
    }
}

extension KeyboardContext {

    /// Perform a settings sync after an async delay.
    func syncAfterAsync(with settings: KeyboardSettings) {
        isAutocapitalizationEnabled = settings.isAutocapitalizationEnabled
    }
}
