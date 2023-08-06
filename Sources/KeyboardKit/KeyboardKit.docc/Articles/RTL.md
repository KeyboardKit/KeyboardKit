# RTL

KeyboardKit supports RTL (right-to-left) locales like ``KeyboardLocale/arabic``,  ``KeyboardLocale/persian``, etc.



## How to see if a locale is LTR or RTL

``KeyboardLocale`` has ``KeyboardLocale/isLeftToRight`` and ``KeyboardLocale/isRightToLeft`` properties that tells you if a locale is left-to-right or right-to-left.

``KeyboardLocale`` also has handy ``KeyboardLocale/allLtr`` and ``KeyboardLocale/allRtl`` collections and collection filters.



## How to configure a keyboard extension to support RTL

You don't need to configure your keyboard extension to support RTL. 

KeyboardKit will automatically change the `primaryLanguage` when you select a locale. This affects things like text direction, spellchecking and the language name in the keyboard switcher.

However, if you exclusively want to use RTL, you can adjust the extension's `Info.plist`:

* Set `PrefersRightToLeft` to `1`.
* Set `PrimaryLanguage` to the language code of your primary RTL language, e.g. `fa` for Perian (Farsi).

This shouldn't be needed, but if you want to configure the keyboard like this, you can. Just be aware that setting the primary language like this may affect external keyboard key mappings.
