# Understanding Localization

This article describes the KeyboardKit localization model and how to use it. 


## Keyboard locale

KeyboardKit has a ``KeyboardLocale`` enum that defines all available keyboard locales.

Keyboard locales have more information than raw locales and can also have a set of related services. For instance, when a KeyboardKit Pro license is registered, it unlocks ways to resolve a ``CalloutActionProvider`` and an ``InputSetProvider`` for each keyboard locale.

Each keyboard locale also has localized content that can be accessed with the ``KKL10n`` enum.


## Localized content

KeyboardKit defines localized strings for each locale in files that are kept under `Resources`.


## How to change the current locale 

You can change the current locale for a keyboard extension by setting ``KeyboardContext/locale`` to a new `Locale` or use the more convenient ``KeyboardContext/setLocale(_:)`` which supports using a ``KeyboardLocale``.

The context uses is a regular `Locale` and not a ``KeyboardLocale``, since it should be possible to use any locale without having to create a new ``KeyboardLocale``. Note however that localization will not work for custom locales.

You can change the available locales of a keyboard extension by setting the ``KeyboardContext/locales`` property. This makes it possible to loop through the available locales with ``KeyboardContext/selectNextLocale()``.

Changing the current locale will cause parts of the keyboard to automatically update, if the locale change also cause the input set or keyboard locale to change.


## How to create a new locale

Adding a new locale to KeyboardKit involves the following:

* Create a new `KeyboardLocale` case.
* Define the locale properties, like `flag`, `isLeftToRight` etc.
* Provide a `Resources/<id>.lproj` folder with localized strings.
* Make sure that the unit tests pass.

For a new keyboard locale to be accepted, it must also define the following features in KeyboardKit Pro:

* A locale-specific `CalloutActionProvider`.
* A locale-specific `InputSetProvider`.

If the locale generates a system keyboard that looks off, you can adjust the ``iPhoneKeyboardLayoutProvider`` and ``iPadKeyboardLayoutProvider`` to handle the new layout. If the layout is completely different, you can implement a new ``KeyboardLayoutProvider`` as well. 

New locales must ensure that the keyboard layout is correct for:

* iPhone portrait
* iPhone landscape
* iPad portrait
* iPad landscape

This involves specifying margins, system actions etc. to make the keyboard behave correctly for all these cases.
