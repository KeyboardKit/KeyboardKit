import Foundation

@available(*, deprecated, renamed: "KeyboardCase")
public typealias KeyboardCasing = KeyboardCase

@available(*, deprecated, renamed: "KeyboardCaseAdjustable")
public typealias CaseAdjustable = KeyboardCaseAdjustable

@available(*, deprecated, message: "This will be removed in KeyboardKit 7")
public extension Sequence where Iterator.Element == [String] {

    /**
     Returns a copy where all nested strings are uppercased.
     */
    func uppercased() -> [Iterator.Element] {
        map { $0.map { $0.uppercased() } }
    }
}

@available(*, deprecated, message: "This will be removed in KeyboardKit 7")
public extension Sequence where Iterator.Element: CaseAdjustable {

    /**
     Return a copy where all nested strings are uppercased.
     */
    func uppercased() -> [String] {
        map { $0.uppercased() }
    }
}
