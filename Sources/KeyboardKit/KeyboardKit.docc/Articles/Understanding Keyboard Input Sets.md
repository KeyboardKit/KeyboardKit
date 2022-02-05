# Understanding Keyboard Input Sets

This article describes the KeyboardKit input set concept and how to use it. 


## Input set

In KeyboardKit, an ``InputSet`` defines the input keys on a keyboard. The keys can then be used to create a ``KeyboardLayout``, which defines the full set of keys including system keys.

Input sets and keyboard layouts are central components when creating a ``SystemKeyboard``, where flexibility and configurability is important features. If you want to create a custom keyboard, you don't have to use these concepts.

The most flexible way to generate an input set is to use an ``InputSetProvider``.


## Input set provider

KeyboardKit has a ``InputSetProvider`` protocol that can be implemented by any classes that can be used to provide ``InputSet`` values for keyboard layouts.

KeyboardKit will create a ``StandardInputSetProvider`` when the keyboard extension is started, then apply that instance to ``KeyboardInputViewController/inputSetProvider`` and use this instance to generate input sets.

KeyboardKit also has an ``EnglishInputSetProvider`` that defines the alphabetic, numeric and symbolic inputs for U.S. English.

KeyboardKit Pro can be used to unlock an input set provider for each ``KeyboardLocale``. This means that you can create a completely localized ``SystemKeyboard`` for all available locales with just a single line of code.


## Device specific input set providers

When creating system keyboards, the input set can vary depending on the device type.

KeyboardKit has a ``DeviceSpecificInputSetProvider`` protocol that you can implement to get access to convenient utilities for creating device-specific input sets.


## How to create a custom input set provider

If you don't have a KeyboardKit Pro license, you can create a custom input set provider.

You can create a custom input set provider by either inheriting and customizing the standard class (which gives you a lot of functionality for free) or by creating a new implementation from scratch. When you're implementation is ready, just replace the controller service with your own implementation to make the library use it instead.

For instance, here is a custom provider that extends ``EnglishInputSetProvider`` and replaces the dollar sign with a Russian ruble sign (₽) (...because, why not?):

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
