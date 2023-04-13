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
