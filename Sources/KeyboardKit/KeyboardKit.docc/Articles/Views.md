# Views

This article describes various KeyboardKit views.

KeyboardKit has views in many different parts of the library. Some are top-level components, while others are nested in namespaces, like ``Autocomplete``.

[KeyboardKit Pro][Pro] unlocks many more views than what are available in KeyboardKit. More information about Pro features can be found in each section.



## Essential Views

KeyboardKit has a ``SystemKeyboard`` that mimics a native iOS keyboards and can be used to create alphabetic, numeric and symbolic keyboards.

![SystemKeyboard](systemkeyboard-english-350.jpg)

``SystemKeyboard`` supports all ``KeyboardLocale``s, custom layouts, callouts, and can be customized and styled to great extent, using a ``KeyboardStyleProvider`` or Pro **Theme**s.

![SystemKeyboard](systemkeyboard-styled-350.jpg)

See the <doc:Essentials> article for more information.



## Autocomplete Views

KeyboardKit has an ``AutocompleteToolbar``, that mimics a native autocomplete toolbar.

![AutocompleteToolbar](autocompletetoolbar-350.jpg)

The bar can be customized, and styled with ``KeyboardStyle/AutocompleteToolbar``:

![AutocompleteToolbar](autocompletetoolbar-styled-350.jpg)

See the <doc:Autocomplete-Article> article for more information.



## Button Views

The ``KeyboardButton`` namespace defines a couple of general button types that can help you mimic native keyboard buttons (or keys).

The ``NextKeyboardButton`` can be used to trigger the system keyboard switcher function, which selects the next keyboard when tapped and shows a keyboard menu when long pressed. 

![NextKeyboardButton](nextkeyboardbutton-250.jpg)

See the <doc:Buttons-Article> article for more information.



## Callout Views

KeyboardKit has a ``Callouts/InputCallout`` that can be show the currently pressed key.

![InputCallout](inputcallout-350.jpg)

KeyboardKit also has a ``Callouts/ActionCallout`` that can present secondary actions.

![InputCallout](actioncallout-350.jpg)

See the <doc:Callouts-Article> article for more infor.



## Dictation

KeyboardKit Pro unlocks dictation views, like this **DictationScreen** and **DictationBarVisualizer**.

![DictationScreen](dictationscreen-350.jpg)

See the <doc:Dictation-Article> article for more information.



## Emoji Views

KeyboardKit Pro unlocks an **EmojiKeyboard** that mimics the native emoji keyboard. 

![Emoji Keyboard](emojikeyboard-350.jpg)

See the <doc:Emojis-Article> article for more information.



## Gestures

KeyboardKit has a ``Gestures/GestureButton`` and a ``Gestures/ScrollViewGestureButton`` that can be used to apply many gestures to the same button.

See the <doc:Gestures-Article> article for more information.



## Images

KeyboardKit has a bunch of **Image** extensions that resolve to SF Symbols, for instance:.

![InputCallout](images-350.jpg)

KeyboardKit also has **Image** extensions that resolve to custom emoji assets, for instance:

![InputCallout](images-emojis-350.jpg)

See the <doc:Images-Article> article for more information.



## Localization

KeyboardKit has a ``LocaleContextMenu`` that can be used to pick locales:

![LocaleContextMenu](localecontextmenu-350.jpg)

See the <doc:Localization-Article> article for more information.



## Previews

KeyboardKit Pro unlocks powerful system keyboard previews. For instance, **SystemKeyboardPreview** can be used to preview different configurations and themes.

![System Keyboard Preview - Turkish](systemkeyboardpreview-350.jpg)

![System Keyboard Preview - Theme](systemkeyboardpreview-theme-350.jpg)

KeyboardKit Pro also unlocks a lightweight **SystemKeyboardButtonPreview** that can be used to preview many styles or themes at once.

![System Keyboard Button Preview](systemkeyboardbuttonpreview-350.jpg)

See the <doc:Previews-Article> article for more information.



## Settings

KeyboardKit has a ``KeyboardSettingsLink`` that can be used to open System Settings:

```swift
KeyboardSettingsLink {
    Text("Open System Settings")
}
```

See the <doc:Settings-Article> article for more information.



## State

KeyboardKit has a ``KeyboardStateLabel`` that can be used to display any keyboard state:

![KeyboardStateLabel](keyboardstatelabel-350.jpg)

See the <doc:State-Article> article for more information.



## Text Routing

KeyboardKit Pro unlocks text input components that automatically register and unregister themselves as proxy when they receive and lose focus:

* **KeyboardTextField** wraps a **UITextField** and can be used for single-line text inputs.
* **KeyboardTextView** wraps a **UITextView** and can be used for multi-line text inputs.

See the <doc:Text-Routing-Article> article for more information.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
