# Localization


## Multi-locale support

KeyboardKit comes with built-in support for English keyboards, but can be extended to support more locales.

These services must be localized to provide a fully localized keyboard:

* `KeyboardInputSetProvider` - Provides the input keys for system keyboads.
* `SecondaryCalloutActionProvider` - Provides secondary callout actions for input keys.

To localize these services, create new instances of the following classes:

* `StandardKeyboardInputSetProvider`
* `StandardSecondaryCalloutActionProvider`

Then replace the input view controller's `keyboardInputSetProvider` and `keyboardSecondaryCalloutActionProvider` with the new instances.

Both takes a list of localized providers, so you can provide them with any locales you like.


## Localized strings

KeyboardKit has a `KKL10n` enum that provides localized texts.

This enum currently supports `English` and `Swedish`.

If you want, I'd gladly accept any PRs that extend this enum with more languages.
