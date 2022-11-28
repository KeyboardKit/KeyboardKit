public extension InputSetProvider {

    /**
     Create an input row from a string.
     */
    @available(*, deprecated, message: "Use InputSet.init(chars:) instead")
    func row(_ chars: String) -> InputSetRow {
        InputSetRow(chars: chars.chars)
    }

    /**
     Create an input row from a char array.
     */
    @available(*, deprecated, message: "Use InputSet.init(chars:) instead")
    func row(_ chars: [String]) -> InputSetRow {
        InputSetRow(chars: chars)
    }
    
    /**
     Create an input row from a lowercased and an uppercased
     strings, which are mapped to `InputSetItem` arrays.

     Both arrays must contain the same amount of characters.
     */
    @available(*, deprecated, message: "Use InputSetRow.init(lowercased:uppercased:) instead")
    func row(
        lowercased: String,
        uppercased: String) -> InputSetRow {
        row(lowercased: lowercased.chars,
            uppercased: uppercased.chars)
    }

    /**
     Create an input row from a lowercased and an uppercased
     string array, which are mapped to `InputSetItem` arrays.

     Both arrays must contain the same amount of characters.
     */
    @available(*, deprecated, message: "Use InputSetRow.init(lowercased:uppercased:) instead")
    func row(
        lowercased: [String],
        uppercased: [String]) -> InputSetRow {
        InputSetRow(
            lowercased: lowercased,
            uppercased: uppercased)
    }
}
