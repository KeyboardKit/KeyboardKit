import Foundation

public extension NumericInputSet {
    
    @available(*, deprecated, renamed: "standardNumeric")
    static func standard(currency: String) -> NumericInputSet {
        standardNumeric(currency: currency)
    }
    
    @available(*, deprecated, renamed: "englishNumeric")
    static func english(currency: String) -> NumericInputSet {
        .englishNumeric(currency: currency)
    }
}

public extension SymbolicInputSet {
    
    @available(*, deprecated, renamed: "standardSymbolic")
    static func standard(currencies: [String]) -> SymbolicInputSet {
        standardSymbolic(currencies: currencies)
    }
    
    @available(*, deprecated, renamed: "englishSymbolic")
    static func english(currency: String) -> SymbolicInputSet {
        .englishSymbolic(currency: currency)
    }
}

@available(*, deprecated, message: "The input set provider concept is deprecated. Use input sets directly instead.")
public protocol InputSetProvider: AnyObject {
    
    var alphabeticInputSet: AlphabeticInputSet { get }

    var numericInputSet: NumericInputSet { get }

    var symbolicInputSet: SymbolicInputSet { get }
}

@available(*, deprecated, message: "Use input sets directly instead.")
public protocol InputSetProviderBased {

    func register(inputSetProvider: InputSetProvider)
}

@available(*, deprecated, message: "Use input sets directly instead.")
open class EnglishInputSetProvider: InputSetProvider, LocalizedService {
    
    public init(
        alphabetic: AlphabeticInputSet = .english,
        numericCurrency: String = "$",
        symbolicCurrency: String = "£"
    ) {
        self.alphabeticInputSet = alphabetic
        self.numericInputSet = .englishNumeric(currency: numericCurrency)
        self.symbolicInputSet = .englishSymbolic(currency: symbolicCurrency)
    }
    
    public var localeKey = KeyboardLocale.english.id
    
    public var alphabeticInputSet: AlphabeticInputSet

    public var numericInputSet: NumericInputSet
    
    public var symbolicInputSet: SymbolicInputSet
}

@available(*, deprecated, message: "Use input sets directly instead.")
public typealias LocalizedInputSetProvider = InputSetProvider & LocalizedService

@available(*, deprecated, message: "Use input sets directly instead.")
open class StandardInputSetProvider: InputSetProvider {
    
    /**
     Create a standard provider.
     
      - Parameters:
        - keyboardContext: The keyboard context to use.
        - localizedProviders: The localized providers to use, by default only `English`.
     */
    public init(
        keyboardContext: KeyboardContext,
        localizedProviders: [LocalizedInputSetProvider] = [EnglishInputSetProvider()]
    ) {
        self.keyboardContext = keyboardContext
        let dict = Dictionary(uniqueKeysWithValues: localizedProviders.map { ($0.localeKey, $0) })
        self.localizedProviders = LocaleDictionary(dict)
    }


    /**
     The keyboard context to use.
     */
    public let keyboardContext: KeyboardContext

    /**
     A dictionary with ``InputSetProvider`` instances.
     */
    public let localizedProviders: LocaleDictionary<InputSetProvider>


    /**
     The provider to use for a certain keyboard context.
     */
    open func provider(for context: KeyboardContext) -> InputSetProvider {
        localizedProviders.value(for: context.locale) ?? EnglishInputSetProvider()
    }
    
    /**
     The input set to use for alphabetic keyboards.
     */
    open var alphabeticInputSet: AlphabeticInputSet {
        provider(for: keyboardContext).alphabeticInputSet
    }
    
    /**
     The input set to use for numeric keyboards.
     */
    open var numericInputSet: NumericInputSet {
        provider(for: keyboardContext).numericInputSet
    }
    
    /**
     The input set to use for symbolic keyboards.
     */
    open var symbolicInputSet: SymbolicInputSet {
        provider(for: keyboardContext).symbolicInputSet
    }
}

@available(*, deprecated, message: "Use input sets directly instead.")
public extension InputSetProvider where Self == PreviewInputSetProvider {
    
    static var preview: InputSetProvider { PreviewInputSetProvider() }
}

@available(*, deprecated, message: "Use input sets directly instead.")
public class PreviewInputSetProvider: InputSetProvider {
    
    /**
     Create a preview provider.
     
     - Parameters:
       - context: The context to use by the preview, by default `.preview`.
     */
    public init(keyboardContext: KeyboardContext = .preview) {
        self.keyboardContext = keyboardContext
        self.provider = StandardInputSetProvider(
            keyboardContext: keyboardContext)
    }
    
    private let keyboardContext: KeyboardContext
    private let provider: InputSetProvider
    
    /**
     The input set to use for alphabetic keyboards.
     */
    public var alphabeticInputSet: AlphabeticInputSet {
        provider.alphabeticInputSet
    }
    
    /**
     The input set to use for numeric keyboards.
     */
    public var numericInputSet: NumericInputSet {
        provider.numericInputSet
    }
    
    /**
     The input set to use for symbolic keyboards.
     */
    public var symbolicInputSet: SymbolicInputSet {
        provider.symbolicInputSet
    }
}

@available(*, deprecated, message: "Use input sets directly instead.")
public class StaticInputSetProvider: InputSetProvider {
    
    /**
     Create a static provider.
     
      - Parameters:
        - alphabeticInputSet: The alphabetic input set to use.
        - numericInputSet: The numeric input set to use.
        - symbolicInputSet: The symbolic input set to use.
     */
    public init(
        alphabeticInputSet: AlphabeticInputSet,
        numericInputSet: NumericInputSet,
        symbolicInputSet: SymbolicInputSet
    ) {
        self.alphabeticInputSetValue = alphabeticInputSet
        self.numericInputSetValue = numericInputSet
        self.symbolicInputSetValue = symbolicInputSet
    }
    
    /**
     Create a static, empty provider.
     */
    public static var empty: InputSetProvider {
        StaticInputSetProvider(
            alphabeticInputSet: AlphabeticInputSet(rows: []),
            numericInputSet: NumericInputSet(rows: []),
            symbolicInputSet: SymbolicInputSet(rows: []))
    }
    
    private let alphabeticInputSetValue: AlphabeticInputSet
    private let numericInputSetValue: NumericInputSet
    private let symbolicInputSetValue: SymbolicInputSet

    /**
     The alphabetic input set to use.
     */
    public var alphabeticInputSet: AlphabeticInputSet {
        alphabeticInputSetValue
    }
    
    /**
     The numeric input set to use.
     */
    public var numericInputSet: NumericInputSet {
        numericInputSetValue
    }
    
    /**
     The symbolic input set to use.
     */
    public var symbolicInputSet: SymbolicInputSet {
        symbolicInputSetValue
    }
}
