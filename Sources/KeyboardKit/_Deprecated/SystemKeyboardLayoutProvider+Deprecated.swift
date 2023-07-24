import Foundation

@available(*, deprecated, message: "These extensions are no longer used and will be removed in KK 8.0")
public extension SystemKeyboardLayoutProvider {

    /**
     The number of alphabetic inputs on each input row.
     */
    var alphabeticInputCount: [Int] {
        inputSetProvider.alphabeticInputSet.rows.map { $0.count }
    }

    /**
     Whether or not the current alphabetic input set has the
     provided number of inputs.
     */
    func hasAlphabeticInputCount(_ rows: [Int]) -> Bool {
        Array(alphabeticInputCount.prefix(rows.count)) == rows
    }

    /**
     Whether or not the current input set is alphabetic with
     the provided number of inputs.
     */
    func isAlphabeticWithInputCount(_ context: KeyboardContext, _ rows: [Int]) -> Bool {
        context.isAlphabetic && hasAlphabeticInputCount(rows)
    }
}

private extension KeyboardContext {

    /// This property makes the context checks above shorter.
    var isAlphabetic: Bool {
        keyboardType.isAlphabetic
    }
}
