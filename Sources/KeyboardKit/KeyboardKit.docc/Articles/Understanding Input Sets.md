# Understanding Input Sets

This article describes the KeyboardKit input set model and how to use it. 



## Input sets vs keyboard layouts

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are central concepts when creating ``SystemKeyboard``s. You can also use them when you create custom keyboards, but you don't have to.

An ``InputSet`` defines the input keys on a keyboard, which can be combined with other actions to create a ``KeyboardLayout`` that defines the full set of actions on a keyboard, as well as their heights, sizes etc. This means that you can use many different input sets with a single keyboard layout. 

A typical system keyboard layout has several rows, where center input buttons are surrounded by action buttons on one or both sides.



## Input set providers

KeyboardKit provides you with a few localized input sets, such as ``AlphabeticInputSet/english``, ``NumericInputSet/english(currency:)`` and ``SymbolicInputSet/english(currency:)``, which can be used to create English keyboards. You can easily create your own custom input sets as well.

However, instead of creating and using input sets directly, the most flexible way is to use an ``InputSetProvider``. KeyboardKit will by default create a ``StandardInputSetProvider`` and apply it to ``KeyboardInputViewController/inputSetProvider`` when it's initialized initialized. You can replace this provider with a custom one if you want to.

KeyboardKit also has an ``EnglishInputSetProvider`` that defines the alphabetic, numeric and symbolic inputs for U.S. English. This provider is used by the standard provider, which supports injecting multiple locale-specific providers.



## KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional input set providers for the 50+ locales it supports, e.g. `PolishInputSetProvider`, localized input sets like `AlphabeticInputSet.filipino` and input set variations like `AlphabeticInputSet.azerty`, `AlphabeticInputSet.qwertz`. 

This means that [KeyboardKit Pro][Pro] lets you create fully localized ``SystemKeyboard``s for all available locales with a single line of code.



## How to create a custom input set provider

You can create a custom input set provider by by implementing the ``InputSetProvider`` protocol.

For instance, here is a custom provider that inherits ``EnglishInputSetProvider`` and replaces the dollar sign with a Yen sign (¥):

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


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
