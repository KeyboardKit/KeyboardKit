import Foundation

public extension KeyboardLocale {

    @available(*, deprecated, message: "Use locale.isLeftToRight instead")
    var isLeftToRight: Bool { locale.isLeftToRight }

    @available(*, deprecated, message: "Use locale.isRightToLeft instead")
    var isRightToLeft: Bool { !isLeftToRight }


    @available(*, deprecated, message: "Use locale.localizedName instead")
    var localizedName: String {
        locale.localizedName
    }
}

public extension Collection where Element == KeyboardLocale {

    @available(*, deprecated, message: "Use .sorted() then .insertingFirst(...) instead")
    func sorted(
        insertFirst locale: Element? = nil
    ) -> [Element] {
        sorted(
            by: { $0.sortName < $1.sortName },
            insertFirst: locale
        )
    }

    @available(*, deprecated, message: "Use .sorted(in:) then .insertingFirst(...) instead")
    func sorted(
        in locale: Locale,
        insertFirst first: Element? = nil
    ) -> [Element] {
        sorted(
            by: { $0.sortName(in: locale) < $1.sortName(in: locale) },
            insertFirst: first
        )
    }

    @available(*, deprecated, message: "Use .sorted(by:) then .insertingFirst(...) instead")
    func sorted(
        by comparator: (Element, Element) -> Bool,
        insertFirst locale: Element?
    ) -> [Element] {
        let sorted = self.sorted(by: comparator)
        guard let locale else { return sorted }
        return sorted.insertingFirst(locale)
    }
}

private extension KeyboardLocale {

    var sortName: String {
        locale.localizedName.lowercased()
    }

    func sortName(in locale: Locale) -> String {
        locale.localizedName(in: locale).lowercased()
    }
}
