# RTL

KeyboardKit supports RTL (right-to-left) locales like ``KeyboardLocale/arabic``,  ``KeyboardLocale/persian``, etc.


## How to see if a locale is LTR or RTL

``KeyboardLocale`` has ``KeyboardLocale/isLeftToRight`` and ``KeyboardLocale/isRightToLeft`` properties that tells you if a locale is left-to-right or right-to-left.

``KeyboardLocale`` also has static ``KeyboardLocale/allLtr`` and ``KeyboardLocale/allRtl`` properties that returns all LTR and RTL locales. This also works on any locale collections.



## How to configure a keyboard extension to support RTL

You don't need to configure your keyboard extension to support RTL. 

KeyboardKit will automatically change the current language when you select an RTL locale, which will affect things like text direction, spellchecking and the language that is presented below the keyboard name in the keyboard switcher.

However, if you exclusively want to use RTL, you can adjust the keyboard extension's' `Info.plist`:

* Set `PrefersRightToLeft` to `1`.
* Set `PrimaryLanguage` to the language code of your primary RTL language, e.g. `fa` for Perian (Farsi).

This should not be needed, but if you want to configure your keyboard like this, you can.
