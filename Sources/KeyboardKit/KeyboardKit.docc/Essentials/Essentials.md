# Essentials

This article describes the essential parts of KeyboardKit.

KeyboardKit extends Apple's native APIs and provides you with a lot more functionality. It lets you mimic the native iOS keyboard and tweak its style and behavior, or create completely custom keyboards.

KeyboardKit also has a ``SystemKeyboard`` view, that mimics the native iOS keyboard and can be customized and styled to great extent.

[KeyboardKit Pro][Pro] unlocks a lot of essential Pro features, like more locales, autocomplete, emoji utilities, dictation, etc. Information about Pro features can be found at the end of this article.



## Keyboard namespace

KeyboardKit has a ``Keyboard`` namespace with basic, keyboard-related types, like ``Keyboard/Case``, ``Keyboard/AutocapitalizationType``, ``Keyboard/ReturnKeyType``, etc.

This namespace doesn't have protocols, open classes, or types that are meant to be top-level.



## Keyboard input view controller

``KeyboardInputViewController`` is the most essential type in the library. Just make your **KeyboardController** inherit this class to get access to a bunch of additional capabilities.

KeyboardKit also has a ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in platforms that don't support UIKit. This is however not fully implemented yet.



## Keyboard context

KeyboardKit has an observable ``KeyboardContext`` class that provides keyboard state, has a ``KeyboardContext/textDocumentProxy`` reference, and lets you get and set ``KeyboardContext/locale``, ``KeyboardContext/keyboardType``, etc.

You can use the context to affect the keyboard. For instance, setting the ``KeyboardContext/keyboardType`` will update the ``SystemKeyboard`` accordingly.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, and syncs it with the controller whenever needed.



## Keyboard behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to define the keyboard's behavior. It's used by e.g. the ``StandardKeyboardActionHandler`` to make decisions.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/services``. You can modify or replace it at any time.



## Extensions

KeyboardKit extends native types with a lot more information, to help with things like autocomplete, text analysis, etc.

Check the extension section in the bottom of the documentation root, or the `Extensions` folder for more info.



## Views

### System Keyboard

KeyboardKit has a ``SystemKeyboard`` that mimics a native iOS keyboards and can be used to create alphabetic, numeric and symbolic keyboards.

![SystemKeyboard](systemkeyboard-english-350.jpg)

``SystemKeyboard`` supports all ``KeyboardLocale``s, custom layouts, callouts, and can be customized and styled to great extent, using a ``KeyboardStyleProvider`` or Pro **Theme**s.

![SystemKeyboard](systemkeyboard-styled-350.jpg)

KeyboardKit will by default use a standard ``SystemKeyboard``. See <doc:Getting-Started> for more information on how you can configure this view, or replace it with any custom view.


### How to customize the system keyboard

``SystemKeyboard`` can be customized to great extent. You can pass in custom services and state, and replace any part of the keyboard:

* **buttonContent** can be used to customize the content view of any button.
* **buttonView** can be used to customize the entire view of any button.
* **emojiKeyboard** can be used to customize the **.emojis** keyboard view.
* **toolbar** can be used to customize the toolbar view above the keyboard.

To use the standard views, just return `{ $0.view }`, or `{ params in params.view }`:

```swift
SystemKeyboard(
    controller: controller,
    buttonContent: { $0.view },
    buttonView: { $0.view },
    emojiKeyboard: { $0.view },
    toolbar: { params in params.view }
)
```

To customize or replace the standard content and item views for any layout item, just return any custom view in any view builder:

```swift
SystemKeyboard(
    controller: controller,
    buttonContent: { $0.view },
    buttonView: { $0.view },
    emojiKeyboard: { $0.view },
    toolbar: { _ in Text("No toolbar here!") }
)
```

Some view builder parameters provide more information. For instance, the button view builders provide you with the full layout item, the toolbar provides you with autocomplete actions, etc.


### Toolbar

Since it's always a a good idea to have at least 50 points above the keyboard, KeyboardKit has a `Keyboard/Toolbar` view that applies a minimum height to its content.




## 👑 Pro features

KeyboardKit Pro unlocks additional, powerful capabilities for the ``SystemKeyboard``.


### Locales

KeyboardKit Pro unlocks localized layouts, callouts, and services for all ``KeyboardLocale``s. This means that you can support up to 63 locales without having to write any additional code.

![SystemKeyboard](systemkeyboard-swedish-350.jpg)


### Emoji Keyboard

KeyboardKit Pro (from Silver and up) will make ``SystemKeyboard`` use an **EmojiKeyboard** view (read more in <doc:Emojis-Article>) as the default emoji keyboard.

![EmojiKeyboard](emojikeyboard-350.jpg)

This means that by just registering a valid license key, your keyboard will automatically show an emoji keyboard when ``KeyboardContext/keyboardType`` changes to ``Keyboard/KeyboardType/emojis``.


### System Keyboard Preview

KeyboardKit Pro unlocks a **SystemKeyboardPreview** that can preview different configurations and themes. It's a regular view that you can place anywhere:

```swift
struct MyView: View {

    var body: some View {
        SystemKeyboardPreview(theme: try? .candyShop)
    }
}
```

See the <doc:Previews-Article> article for more information.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
