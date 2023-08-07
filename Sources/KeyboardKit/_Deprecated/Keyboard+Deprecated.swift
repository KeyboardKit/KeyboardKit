#if os(iOS) || os(tvOS)
import Foundation

@available(*, deprecated, renamed: "Keyboard.AutocapitalizationType")
public typealias KeyboardAutocapitalizationType = Keyboard.AutocapitalizationType

@available(*, deprecated, renamed: "Keyboard.BackspaceRange")
public typealias KeyboardBackspaceRange = Keyboard.BackspaceRange

@available(*, deprecated, renamed: "Keyboard.Case")
public typealias KeyboardCase = Keyboard.Case

@available(*, deprecated, renamed: "Keyboard.ReturnKeyType")
public typealias KeyboardReturnKeyType = Keyboard.ReturnKeyType

@available(*, deprecated, renamed: "Keyboard.KeyboardType")
public typealias KeyboardType = Keyboard.KeyboardType

@available(*, deprecated, renamed: "KeyboardEnabledContext")
public typealias KeyboardEnabledState = KeyboardEnabledContext
#endif
