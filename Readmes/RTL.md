# RTL

KeyboardKit supports RTL (right-to-left) locales, but your extension need to be configured to support it.


## Supported Locales

KeyboardKit currently supports the following RTL locales:

* 🇮🇷 Persian

Applying an RTL locale will cause the keyboard extension layout to be flipped.


## Current limitations

KeyboardKit currently doesn't support mixing LTR and RTL locales in the same keyboard extension.

To use both LTR and RTL, you must currently create two different keyboard extensions.

You can however support multiple locales in the same extension, as long as they are all LTR or RTL. 
 

## Enable RTL

To enable RTL for your keyboard extension, adjust the keyboard extension's Info.plist as such:

* Set `PrefersRightToLeft` to `1`.
* Set `PrimaryLanguage` to the language code of your primary RTL language, e.g. `fa` for Perian (Farsi).
