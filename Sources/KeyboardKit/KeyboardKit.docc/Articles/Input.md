# Input

This article describes the KeyboardKit input set engine and how to use it.

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are central concepts when creating a ``SystemKeyboard``. You can also use them to create custom keyboards, although you don't have to.

An ``InputSet`` defines the input keys on a keyboard, while a ``KeyboardLayout`` defines the full set of actions on a keyboard, as well as their heights, sizes etc. This means that you can use many different input sets with a single keyboard layout. 

A typical system keyboard layout has several rows, where center input buttons are surrounded by action buttons on one or both sides.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Input set providers

KeyboardKit provides you with a few localized input sets, such as ``AlphabeticInputSet/english``, ``NumericInputSet/english(currency:)`` and ``SymbolicInputSet/english(currency:)``, which can be used to create English keyboards. You can easily create your own custom input sets as well. However, instead of creating and using input sets directly, the most flexible way is to use an ``InputSetProvider``. 

KeyboardKit will by default create a ``StandardInputSetProvider`` and apply it to the input controller's ``KeyboardInputViewController/inputSetProvider``. You can replace it with a custom provider to customize the standard input sets.

KeyboardKit also has an ``EnglishInputSetProvider`` that defines the alphabetic, numeric and symbolic inputs for U.S. English. This provider is used by the standard provider, which supports injecting multiple locale-specific providers.



## How to customize the standard provider

If you want to make minor customizations to the ``StandardInputSetProvider``, there are a couple of options:

* Add more localized providers to the ``StandardInputSetProvider`` instance. 
* Subclass ``StandardInputSetProvider`` and override its functions.

You can also create a completely custom input set provider, see below.



## How to create a custom provider

You can create a custom input set provider by either inheriting and customizing the ``StandardInputSetProvider`` base class, which gives you a lot of functionality for free, or by implementing ``InputSetProvider`` from scratch.

For instance, here is a custom provider that inherits ``EnglishInputSetProvider`` and replaces the dollar sign with a Yen sign (¥):

```swift
class MyInputSetProvider: EnglishInputSetProvider {

    public init() {
        super.init(numericCurrency: "₽", symbolicCurrency: "$")
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


## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional input sets and input set providers for all keyboard locales, as well as input set variations like ``AlphabeticInputSet/azerty`` and ``AlphabeticInputSet/qwertz``. 

This lets you create a fully localized ``SystemKeyboard`` for all available locales with a single line of code.

You can also access the underlying, locale-specific providers like this:

```swift
let provider = ProInputSetProvider.Swedish()
```

You can access all providers that your license unlocks like this:

```swift
let providers = license.localizedInputSetProviders
```

If you want to use a custom provider with KeyboardKit Pro, make sure to register your custom instance *after* registering your license key, otherwise it will be overwritten by the license registration process.

You can still inherit `StandardInputSetProvider` with KeyboardKit Pro to get the standard behavior, combined with the additional functionality that your Pro license unlocks:

```swift
class CustomInputSetProvider: StandardInputSetProvider {

    override var alphabeticInputSet: AlphabeticInputSet {
        let baseSet = super.alphabeticInputSet
        let customSet = // Your custom logic here
        return customSet
    }
}
```

You can then create a custom provider instance with your license, like this:

```swift
open func setupKeyboardKit() {
    try? setupPro(withLicenseKey: key, view: keyboardView) { license in
        self.setupCustomServices(with: license)
    }
}

func setupCustomServices(with license: License) {
    inputSetProvider = CustomInputSetProvider(
        keyboardContext: keyboardContext,
        localizedProviders: license.localizedInputSetProviders
    )
}
```

You can of course add a custom initializer to your custom provider if you need additional things in it, then just call `super.init` to setup the rest. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
