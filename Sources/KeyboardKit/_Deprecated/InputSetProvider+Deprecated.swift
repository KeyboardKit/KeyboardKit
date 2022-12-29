public extension InputSetProvider {

    /**
     Create an input row from a string.
     */
    @available(*, deprecated, message: "Use InputSetRow(chars:) instead")
    func row(_ chars: String) -> InputSetRow {
        InputSetRow(chars: chars.chars)
    }

    /**
     Create an input row from a char array.
     */
    @available(*, deprecated, message: "Use InputSetRow(chars:) instead")
    func row(_ chars: [String]) -> InputSetRow {
        InputSetRow(chars: chars)
    }
    
    /**
     Create an input row from a lowercased and an uppercased
     strings, which are mapped to `InputSetItem` arrays.

     Both arrays must contain the same amount of characters.
     */
    @available(*, deprecated, message: "Use InputSetRow(lowercased:uppercased:) instead")
    func row(
        lowercased: String,
        uppercased: String
    ) -> InputSetRow {
        InputSetRow(
            lowercased: lowercased.chars,
            uppercased: uppercased.chars
        )
    }

    /**
     Create an input row from a lowercased and an uppercased
     string array, which are mapped to `InputSetItem` arrays.

     Both arrays must contain the same amount of characters.
     */
    @available(*, deprecated, message: "Use InputSetRow(lowercased:uppercased:) instead")
    func row(
        lowercased: [String],
        uppercased: [String]
    ) -> InputSetRow {
        InputSetRow(
            lowercased: lowercased,
            uppercased: uppercased
        )
    }
}

public extension StandardInputSetProvider {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead.")
    convenience init(
        context: KeyboardContext,
        providers: [LocalizedInputSetProvider] = [EnglishInputSetProvider()]
    ) {
        self.init(keyboardContext: context, localizedProviders: providers)
    }
}

public extension PreviewInputSetProvider {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead.")
    convenience init(context: KeyboardContext) {
        self.init(keyboardContext: context)
    }
}

/**
 This protocol extends `InputSetProvider` and can be used by
 any provider that bases its input set on the current device.

 For now, this provider will return the iPhone input set for
 any device that is not explicitly iPad.
 */
@available(*, deprecated, message: "DeviceSpecificInputSetProvider is no longer needed")
public protocol DeviceSpecificInputSetProvider: InputSetProvider {}

@available(*, deprecated, message: "DeviceSpecificInputSetProvider is no longer needed")
public extension DeviceSpecificInputSetProvider {

    /**
     Create an input row from phone and pad-specific strings.
     */
    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(
        phone: String,
        pad: String,
        deviceType: DeviceType = .current
    ) -> InputSetRow {
        InputSetRow(chars: deviceType == .pad ? pad.chars : phone.chars)
    }

    /**
     Create an input row from phone and pad-specific arrays.
     */
    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(
        phone: [String],
        pad: [String],
        deviceType: DeviceType = .current
    ) -> InputSetRow {
        InputSetRow(chars: deviceType == .pad ? pad : phone)
    }

    /**
     Create an input row from phone and pad-specific strings.
     */
    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(
        phoneLowercased: String,
        phoneUppercased: String,
        padLowercased: String,
        padUppercased: String,
        deviceType: DeviceType = .current) -> InputSetRow {
        InputSetRow(
            lowercased: deviceType == .pad ? padLowercased.chars : phoneLowercased.chars,
            uppercased: deviceType == .pad ? padUppercased.chars : phoneUppercased.chars)
    }

    /**
     Create an input row from phone and pad-specific arrays.
     */
    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(
        phoneLowercased: [String],
        phoneUppercased: [String],
        padLowercased: [String],
        padUppercased: [String],
        deviceType: DeviceType = .current) -> InputSetRow {
        InputSetRow(
            lowercased: deviceType == .pad ? padLowercased : phoneLowercased,
            uppercased: deviceType == .pad ? padUppercased : phoneUppercased)
    }
}
