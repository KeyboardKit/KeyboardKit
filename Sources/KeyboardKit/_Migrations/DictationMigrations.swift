import Foundation
import SwiftUI

@available(*, deprecated, renamed: "DictationService", message: "Migration Deprecation, will be removed in 9.1!")
public typealias KeyboardDictationService = DictationService

public extension Dictation {

    @available(*, deprecated, renamed: "DisabledDictationService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias DisabledKeyboardService = DisabledDictationService

    @available(*, deprecated, renamed: "StandardDictationService", message: "Migration Deprecation, will be removed in 9.1!")
    typealias ProKeyboardService = StandardDictationService
}

public extension View {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! You must now pass in a keyboardContext and an openURL for dictation to work.")
    func keyboardDictation<Overlay: View>(
        context: DictationContext,
        speechRecognizer: DictationSpeechRecognizer,
        @ViewBuilder overlay: () -> Overlay
    ) -> some View {
        self
    }
}
