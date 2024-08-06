import Foundation

public extension Dictation.KeyboardConfiguration {

    @available(*, deprecated, message: "This is no longer used.")
    init(context: DictationContext) {
        self.appGroupId = context.appGroupId ?? ""
        self.appDeepLink = context.appDeepLink ?? ""
    }
}
