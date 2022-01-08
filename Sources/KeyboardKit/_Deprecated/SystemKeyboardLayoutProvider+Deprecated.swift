import Foundation

public extension SystemKeyboardLayoutProvider {
    
    @available(*, deprecated, message: "This is no longer used by the library and will be removed")
    var hasElevenElevenSevenAlphabeticInput: Bool {
        alphabeticInputCount.prefix(3) == [11, 11, 7]
    }
    
    @available(*, deprecated, message: "This is no longer used by the library and will be removed")
    var hasElevenElevenEightAlphabeticInput: Bool {
        alphabeticInputCount.prefix(3) == [11, 11, 8]
    }
    
    @available(*, deprecated, message: "This is no longer used by the library and will be removed")
    var hasElevenElevenNineAlphabeticInput: Bool {
        alphabeticInputCount.prefix(3) == [11, 11, 9]
    }
    
    @available(*, deprecated, message: "This is no longer used by the library and will be removed")
    var hasElevenElevenTenAlphabeticInput: Bool {
        alphabeticInputCount.prefix(3) == [11, 11, 10]
    }
    
    @available(*, deprecated, message: "This is no longer used by the library and will be removed")
    var hasElevenElevenElevenAlphabeticInput: Bool {
        alphabeticInputCount.prefix(3) == [11, 11, 11]
    }
}
