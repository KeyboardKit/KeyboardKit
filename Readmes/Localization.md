# Localization


## Multi-locale support

KeyboardKit comes with built-in support for English keyboards, but can be extended to support more locales.

These services must be localized to provide a fully localized keyboard:

* `KeyboardInputSetProvider` - Provides input keys for system keyboards.
* `SecondaryCalloutActionProvider` - Provides secondary callout actions for keyboard actions.
* `KeyboardLayoutProvider` - Provides the full keyboard layout as well as size information.
* Various behaviors, such as how " behaves.

To localize these services, create new implementations of the above protocols and replace these input view controller properties:

* `keyboardInputSetProvider`
* `keyboardLayoutProvider`
* `keyboardSecondaryCalloutActionProvider`

If you upgrade to KeyboardKit Pro, your keyboard will automatically register the locales that you have unlocked. 

Have a look at the demo app to see how you register more locales without upgrading to KeyboardKit Pro.


## Localized strings

KeyboardKit has a `KKL10n` enum that provides localized texts.

This enum currently supports:

* 🇺🇸 English
* 🇩🇪 German
* 🇮🇹 Italian
* 🇸🇪 Swedish

If you want, I'd gladly accept any PRs that extend this enum with more languages.


## KeyboardKit Pro

KeyboardKit Pro extends KeyboardKit with more locales.

Registering KeyboardKit Pro can unlock the following locales:

* 🇩🇪 German
* 🇮🇹 Italian
* 🇸🇪 Swedish

Different licenses support a different number of additional locales.
