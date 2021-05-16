# Localization

KeyboardKit is localized in the following languages:

* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇺🇸 English (US)
* 🇬🇧 English (UK)
* 🇫🇮 Finnish
* 🇫🇷 French
* 🇩🇪 German
* 🇮🇹 Italian
* 🇳🇴 Norwegian
* 🇸🇪 Swedish 


## Localized strings

KeyboardKit has a `KKL10n` enum that provides localized texts for all locales. These texts are used by e.g. the `SystemKeyboard` componens, to localize certain keyboard keys.

Localized texts are managed under `Sources/Resources`.


## Localized keyboards

Localized keyboards involves other parts than just localized strings.

For instance, the following services must be localized in order to implement a localized keyboard:

* `KeyboardLocale` - A keyboard-specific enum containing the locales above.
* `KeyboardInputSetProvider` - Provides input keys for a system keyboard.
* `SecondaryCalloutActionProvider` - Provides secondary callout actions.
* `KeyboardLayoutProvider` - Provides the full keyboard layout (inputs + actions).

While `KeyboardInputSetProvider` and `SecondaryCalloutActionProvider` *must* be localized, a new `KeyboardLayoutProvider` only has to be implemented if the keyboard layout deviates from the English 10-9-7 layout or the German 11-11-7 one.   

To localize these services, create new implementations of the above protocols and replace these input view controller properties:

* `keyboardInputSetProvider`
* `keyboardLayoutProvider`
* `keyboardSecondaryCalloutActionProvider`

Have a look at the demo app to see how it registers English-specific services. You don't have to do this in your own keyboards, since Engish is the default language and the only language that is implemented in KeyboardKit. It's just there to show you how to do it.


## KeyboardKit Pro

[KeyboardKit Pro][Pro] extends KeyboardKit with support for more localized services and keyboards. While KeyboardKit comes with built-in support for English (US), [KeyboardKit Pro][Pro] adds support for all locales above.

If you upgrade to KeyboardKit Pro, your keyboard will automatically register the locales that you have unlocked.

Read more [here][Pro].


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
