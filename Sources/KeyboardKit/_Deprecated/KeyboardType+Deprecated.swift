import Foundation

public extension KeyboardType {
    
    @available(*, deprecated, message: "Just set keyboardType directly.")
    func canBeReplaced(with type: KeyboardType) -> Bool {
        guard
            case .alphabetic(let state) = self,
            case .alphabetic(let newState) = type
        else { return true }
        if state == .capsLocked && newState == .uppercased { return false }
        return true
    }
    
    @available(*, deprecated, renamed: "standardButtonText")
    var systemKeyboardButtonText: String? { standardButtonText }
}
