import Foundation

public extension KeyboardLocale {

    @available(*, deprecated, message: "Use locale.localizedName instead")
    var localizedName: String {
        locale.localizedName
    }
}
