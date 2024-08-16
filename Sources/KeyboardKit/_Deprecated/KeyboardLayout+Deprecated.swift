import Foundation
import SwiftUI

public extension InputSet {

    @available(*, deprecated, renamed: "numeric")
    static func standardNumeric(currency: String) -> InputSet {
        numeric(currency: currency)
    }

    @available(*, deprecated, renamed: "symbolic")
    static func standardSymbolic(currencies: [String]) -> InputSet {
        symbolic(currencies: currencies)
    }
}


public extension KeyboardLayout {
    
    @available(*, deprecated, renamed: "hasKeyboardSwitcher(_:)")
    func hasKeyboardSwitcher(for type: Keyboard.KeyboardType) -> Bool {
        itemRows.hasKeyboardSwitcher(type)
    }

    @available(*, deprecated, renamed: "KeyboardLayout.BaseService")
    typealias BaseProvider = KeyboardLayout.BaseService

    @available(*, deprecated, renamed: "KeyboardLayout.DeviceBasedService")
    typealias DeviceBasedProvider = KeyboardLayout.DeviceBasedService

    @available(*, deprecated, renamed: "KeyboardLayout.DisabledService")
    typealias DisabledProvider = KeyboardLayout.DisabledService

    @available(*, deprecated, renamed: "KeyboardLayout.iPadService")
    typealias iPadProvider = KeyboardLayout.iPadService

    @available(*, deprecated, renamed: "KeyboardLayout.iPhoneService")
    typealias iPhoneProvider = KeyboardLayout.iPhoneService

    @available(*, deprecated, renamed: "KeyboardLayout.StandardService")
    typealias StandardProvider = KeyboardLayout.StandardService

}

public extension KeyboardLayout.DeviceBasedService {

    @available(*, deprecated, renamed: "iPadService")
    var iPadProvider: KeyboardLayoutService {
        get { iPadService }
        set { iPadService = newValue }
    }

    @available(*, deprecated, renamed: "iPhoneService")
    var iPhoneProvider: KeyboardLayoutService {
        get { iPhoneService }
        set { iPhoneService = newValue }
    }
}

@available(*, deprecated, renamed: "KeyboardLayoutRowIdentifiable")
public typealias KeyboardLayoutRowItem = KeyboardLayoutRowIdentifiable

@available(*, deprecated, renamed: "KeyboardLayoutIdentifiable")
public typealias KeyboardLayoutRowIdentifiable = KeyboardLayoutIdentifiable

@available(*, deprecated, renamed: "KeyboardLayoutService")
public typealias KeyboardLayoutProvider = KeyboardLayoutService

@available(*, deprecated, renamed: "KeyboardLayoutServiceProxy")
public typealias KeyboardLayoutProviderProxy = KeyboardLayoutServiceProxy

public extension KeyboardLayoutServiceProxy {

    @available(*, deprecated, renamed: "iPadService")
    var iPadProvider: KeyboardLayoutService { iPadService }

    @available(*, deprecated, renamed: "iPhoneService")
    var iPhoneProvider: KeyboardLayoutService { iPhoneService }
}

public extension KeyboardLayout.Configuration {
    
    @available(*, deprecated, renamed: "init(buttonCornerRadius:buttonInsets:rowHeight:inputToolbarHeight:)")
    init(
        buttonCornerRadius: Double,
        buttonInsets: EdgeInsets,
        rowHeight: Double,
        numberToolbarHeight: Double
    ) {
        self.init(
            buttonCornerRadius: buttonCornerRadius,
            buttonInsets: buttonInsets,
            rowHeight: rowHeight,
            inputToolbarHeight: numberToolbarHeight
        )
    }
    
    @available(*, deprecated, renamed: "inputToolbarHeight")
    var numberToolbarHeight: Double {
        get { inputToolbarHeight }
        set { inputToolbarHeight = newValue }
    }
}
