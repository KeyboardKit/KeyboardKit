import Foundation
import SwiftUI

public extension DictationContext {

    /// DEPRECATED!
    ///
    /// > Warning: Settings have been moved into the context.
    /// This will be removed in KeyboardKit 9.0.
    func sync(with settings: DictationSettings) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: settings)
        }
    }
}

extension DictationContext {

    func syncAfterAsync(with settings: DictationSettings) {
        if silenceLimit != settings.silenceLimit {
            silenceLimit = settings.silenceLimit
        }
    }
}
