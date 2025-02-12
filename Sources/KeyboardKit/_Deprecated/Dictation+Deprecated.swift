import Foundation

public extension DictationContext {
    
    @available(*, deprecated, message: "This is no longer used. Use DictationSettings.settingsPrefix instead")
    static var settingsPrefix: String {
        DictationSettings.settingsPrefix
    }
    
    @available(*, deprecated, message: "This is no longer used. Use KeyboardSettings.store instead")
    static var peristentStore: UserDefaults {
        KeyboardSettings.store
    }
}
