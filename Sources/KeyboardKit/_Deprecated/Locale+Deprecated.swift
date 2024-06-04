import Foundation

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public extension Locale {

    @available(*, deprecated, message: "Use KeyboardLocale instead")
    var flag: String? {
        let regionIdentifier = region?.identifier
        let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
        let flag = regionIdentifier?
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(flagBase + $0.value)?.description }
            .joined()
        return flag ?? ""
    }
}
