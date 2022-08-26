# Understanding Input Sets

This article describes the KeyboardKit input set model and how to use it. 


## Input sets

In KeyboardKit, an ``InputSet`` defines input keys on a keyboard, which can then be combined with other actions to create a ``KeyboardLayout``, which defines the full set of keys on a keyboard.

Input sets and keyboard layouts are central components when creating a ``SystemKeyboard``, where flexibility and configurability is important features. If you want to create a custom keyboard, you don't have to use these concepts.

KeyboardKit provides you with a few localized input sets, such as ``AlphabeticInputSet/english``, ``NumericInputSet/english(currency:)`` and ``SymbolicInputSet/english(currency:)``.


## Input set providers

KeyboardKit has a ``InputSetProvider`` protocol that can be implemented by any classes that can be used to provide alphabetic, numeric and symbolic ``InputSet``s.

KeyboardKit will by default create a ``StandardInputSetProvider`` and apply it to ``KeyboardInputViewController/inputSetProvider``, which is then used by default. You can replace this standard instance with a custom one.

KeyboardKit also has an ``EnglishInputSetProvider`` that defines the alphabetic, numeric and symbolic inputs for U.S. English. This provider is used by the standard provider, which supports injecting multiple locale-specific providers.

KeyboardKit Pro contains additional input set providers for the 50+ locales it supports. This means KeyboardKit Pro lets you create a completely localized ``SystemKeyboard`` for all available locales with just a single line of code.


## Input set variations

Some languages have support for multiple input set variations. For instance, English supports `QWERTY`, `AZERTY`, `QWERTZ` and `Dvorak`.

KeyboardKit supports these variations for `English`, while KeyboardKit Pro contains additional variations for the 50+ locales it supports. 


## How to create a custom input set provider

If you don't have a KeyboardKit Pro license, you can create a custom input set provider.

You can create a custom input set provider by by implementing the ``InputSetProvider`` protocol.

For instance, here is a custom provider that inherits ``EnglishInputSetProvider`` and replaces the dollar sign with a Russian ruble sign (₽) (...because, why not?):

```swift
class MyInputSetProvider: EnglishInputSetProvider {
    
    override var numericInputSet: NumericInputSet {
        
        public init() {
            super.init(numericCurrency: "₽", symbolicCurrency: "$")
        }
    }
}
```

To use this implementation instead of the standard one, just replace the standard instance like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        inputSetProvider = MyInputSetProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.
