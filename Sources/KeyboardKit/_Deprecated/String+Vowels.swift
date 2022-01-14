import Foundation

public extension String {
    
    @available(*, deprecated, message: "This property will be removed in 6.0")
    var isVowel: Bool {
        Self.vowels.contains(self.lowercased())
    }
    
    @available(*, deprecated, message: "This property will be removed in 6.0")
    static var vowels = "aeiouüyåäæöø"
}
