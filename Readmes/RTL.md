# RTL

KeyboardKit supports RTL (right-to-left) locales, but your extension need to be configured to support it.


## Supported Locales

KeyboardKit supports a couple of RTL locales, such as Arabic, Kurdish Sorani and Persian.


## Mixing LTR and RTL

KeyboardKit currently doesn't support mixing LTR and RTL in the same keyboard extension. To support both LTR and RTL, you must create two different keyboard extensions.

You can however support multiple locales in the same extension, as long as they all have the same text direction. 
 

## Enable RTL

To enable RTL for your keyboard extension, adjust the keyboard extension's Info.plist as such:

* Set `PrefersRightToLeft` to `1`.
* Set `PrimaryLanguage` to the language code of your primary RTL language, e.g. `fa` for Perian (Farsi).
