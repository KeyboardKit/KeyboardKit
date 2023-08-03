# External Keyboards

This article describes the KeyboardKit external keyboard engine.

KeyboardKit lets you detect whether or not an external keyboard is used, including snap-on Smart Folio iPad keyboards, the Magic Keyboard, Bluetooth keyboards etc.



## How to detect an external keyboard

KeyboardKit has an ``ExternalKeyboardContext`` that lets you detect whether or not an external keyboard is connected to the device. To use it, just set it up as an observed object in your keyboard controller. 

Since this context requires iOS 14, this is not setup by the ``KeyboardInputViewController``.



## Primary language and key mapping

The way iOS will handle external keyboard key mapping when your keyboard extension is active depends on the extension's primary language configuration, which you can setup in the extension `Info.plist` under `NSExtension` > `NSExtensionAttributes` > `PrimaryLanguage`.

The standard `en-US` primary language will not interfere with the key mapping, which means that typing on a Swedish keyboard will map special characters like `å`, `ä` and `ö` correctly. However, using this locale identifier will make the keyboard list itself as an English keyboard in System Settings.

You may therefore be tempted to use `mul` as the primary langage, since that will make the extension list itself as "Multiple languages", but doing so will mess up the hardware key mappings. For Swedish, the `å`, `ä` and `ö` keys will now insert `[`, `´` and `;` instead.

So although it may be tempting to use `mul` as the primary langage, consider the effect it will have on any external keyboards. 



## Current limitations

The ``ExternalKeyboardContext`` will currently only detect if a keyboard is connected or not. For a folio keyboard, which can be inactive (folded back) while connected, it currently can't tell if the keyboard is active or not, only if it's connected, which it always is.

If you know how to differ between being connected and active, please send a PR.
