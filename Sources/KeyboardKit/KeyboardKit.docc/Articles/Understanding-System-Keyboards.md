# Understanding System Keyboards

This article describes the KeyboardKit system keyboard.

Since Apple just provides a very limited API to custom keyboard extensions, you have to implement most functionality from scratch, including the keyboard view itself.

KeyboardKit therefore has a ``SystemKeyboard`` that can be used to create alphabetic, numeric, symbolic and unicode-based keyboards that mimic the native iOS keyboard. 

System keyboards can be customized and styled to great extent, using styles and themes, and automatically adjusts to the observable state you pass in. 

[KeyboardKit Pro][Pro] unlocks powerful system keyboard and theme previews when you register a valid license key. Information about Pro features can be found at the end of this article.



## How to set up a system keyboard

KeyboardKit will by default use a standard ``SystemKeyboard`` if you don't provide a custom view. So, if you just want to use such a standard keyboard, you don't have to do anything.

If you want to customize the system keyboard, or wrap it in another view like a `VStack`, you just have to override the ``KeyboardInputViewController/viewWillSetupKeyboard()`` and call any of the `setup(with:)` functions with a custom view.

```swift
class KeyboardController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            VStack(spacing: 0) {
                MyCustomToolbar()
                SystemKeyboard(
                    controller: controller,
                    autocompleteToolbar: .none,
                    buttonContent: { $1 },
                    buttonView: { $1 }
                )
            }
        }
    }
}
```

The setup view builder provides an `unowned` controller reference to avoid reference cycles and memory leaks. Make sure to keep any additional references to it `unowned`, for instance when passing it into another view.


## How to customize a system keyboard

A ``SystemKeyboard`` can be customized and styled to great extent.

For instance, you can pass in custom keyboard layouts to it, and provide it with custom services and observable state to it to modify its behavior. 

The `buttonContent` and `buttonView` parameters can be used to customize the content or the entire view of any keyboard button. These functions are called for each layout item and the standard view.

To use the standard content and item views, just return the provided ones with `{ $1 }`, or `{ item, view in view }` if you prefer more expressive code:

```swift
SystemKeyboard(
    controller: controller,
    buttonContent: { $1 },
    buttonView: { item, view in view }
)
```  

To customize or replace the standard content and item views for any item, just provide custom builders like this:

```swift
SystemKeyboard(
    controller: controller,
    buttonContent: { item, view in
        switch item.action {
        case .backspace: Image(systemName: "trash")
        default: view
        }
    },
    buttonView: { item, view in
        switch item.action {
        case .space: Text("This is true, empty space")
            .opacity(0)
            .frame(maxWidth: .infinity)
        default: view
        }
    }
)
```

In the code above, the backspace content is replaced with a trashbin and the entire spacebar is replaced by transparent text that takes up as much space as needed.

The system keyboard will place an ``AutocompleteToolbar`` topmost, if you explicitly tell it not to. It will also overlay an emoji keyboard over the keyboard, whenever the keyboard context's ``KeyboardContext/keyboardType`` is set to `.emojis`.

Since the keyboard layout depends on the available keyboard width, you must pass in a `width`, if you don't want to use the current controller's width.

You can take a look at the source code of the various views in the library for inspiration.



## 👑 Pro features

KeyboardKit Pro unlocks powerful tools to preview system keyboards and themes:

```swift
SystemKeyboardPreview(...)              // A live system keyboard preview.
SystemKeyboardPreviewHeader(...)        // A live system keyboard preview header.
SystemKeyboardThemePreview(...)         // A live theme preview.
SystemKeyboardThemePreviewHeader(...)   // A live theme preview header.
```

Since these views render system keyboards with full interation, they are quite performance demanding. 

To preview many styles or themes at once, you can use these more lightweight previews:

```swift
SystemKeyboardButtonPreview(...)        // A system button preview.
SystemKeyboardButtonThemePreview(...)   // A system button preview for a theme.
```

These previews only render lightweight buttons.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
