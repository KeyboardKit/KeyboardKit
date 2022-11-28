import Foundation

public extension InputSetRows {

    /**
     Create input rows from a list of string array, that are
     mapped to a `InputSetRow` array.
     */
    @available(*, deprecated, message: "Use input set row initializers instead")
    init(_ rows: [[String]]) {
        self = rows.map { InputSetRow(chars: $0) }
    }

    /**
     Create input row from lowercased and an uppercased list
     arrays, which are mapped to `InputSetRow` arrays.

     Both arrays must contain the same amount of characters.
     */
    @available(*, deprecated, message: "Use input set row initializers instead")
    init(lowercased: [[String]], uppercased: [[String]]) {
        assert(lowercased.count == uppercased.count, "The lowercased and uppercased string arrays must contain the same amount of characters")
        self = lowercased.enumerated().map {
            InputSetRow(
                lowercased: lowercased[$0.offset],
                uppercased: uppercased[$0.offset])
        }
    }
}
