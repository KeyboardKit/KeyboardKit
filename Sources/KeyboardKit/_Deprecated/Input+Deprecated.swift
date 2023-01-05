public extension InputSetProvider {

    @available(*, deprecated, message: "Use InputSetRow(chars:) instead")
    func row(_ chars: String) -> InputSetRow {
        InputSetRow(chars: chars.chars)
    }

    @available(*, deprecated, message: "Use InputSetRow(chars:) instead")
    func row(_ chars: [String]) -> InputSetRow {
        InputSetRow(chars: chars)
    }
    
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

@available(*, deprecated, message: "DeviceSpecificInputSetProvider is no longer needed")
public protocol DeviceSpecificInputSetProvider: InputSetProvider {}

@available(*, deprecated, message: "DeviceSpecificInputSetProvider is no longer needed")
public extension DeviceSpecificInputSetProvider {

    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(
        phone: String,
        pad: String,
        deviceType: DeviceType = .current
    ) -> InputSetRow {
        InputSetRow(chars: deviceType == .pad ? pad.chars : phone.chars)
    }

    @available(*, deprecated, message: "Use InputSetRow initializer instead")
    func row(
        phone: [String],
        pad: [String],
        deviceType: DeviceType = .current
    ) -> InputSetRow {
        InputSetRow(chars: deviceType == .pad ? pad : phone)
    }

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

public extension InputSetRows {

    @available(*, deprecated, message: "Use input set row initializers instead")
    init(_ rows: [[String]]) {
        self = rows.map { InputSetRow(chars: $0) }
    }

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

public extension InputSetRow {

    @available(*, deprecated, message: "Use chars: initializer instead.")
    init(_ chars: String) {
        self.init(chars: chars.chars)
    }

    @available(*, deprecated, message: "Use chars: initializer instead.")
    init(_ row: [String]) {
        self.init(chars: row)
    }
}
