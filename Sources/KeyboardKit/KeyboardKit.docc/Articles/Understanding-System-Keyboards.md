# Understanding System Keyboards

This article describes the KeyboardKit system keyboard.

As you may have noticed, Apple provides a very limited API to custom keyboard extensions. You have to implement much functionality from scratch, including the keyboard view itself.

KeyboardKit therefore has a ``SystemKeyboard`` that can be used to create alphabetic, numeric and symbolic keyboards that mimic the native iOS keyboard. It can be customized and styled to great extent, and automatically adjusts to the observable state you pass in. 

[KeyboardKit Pro][Pro] unlocks powerful system keyboard previews when you register a valid license key, and will also make it support emoji keyboards. Information about Pro features can be found at the end of this article.



## How to set up a system keyboard

KeyboardKit will by default use a standard ``SystemKeyboard``. If you just want to use this view, you don't have to do anything.

If you however want to customize the system keyboard, wrap it in another view like a `VStack` or use a custom view, you must override ``KeyboardInputViewController/viewWillSetupKeyboard()`` and call any of the `setup(with:)` functions with a custom view.

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

The setup function's view builder provides an `unowned` controller reference to avoid reference cycles and memory leaks. Make sure to keep any additional references to it `unowned`, for instance when passing it into another view.


## How to customize a system keyboard

A ``SystemKeyboard`` can be customized and styled to great extent. For instance, you can pass in custom keyboard layouts to it, and provide it with custom services and observable state to it to modify its behavior. 

The `buttonContent` and `buttonView` parameters can be used to customize the content or the entire view of any button.

The `emojiKeyboard` parameter defines the view that will be used for the ``Keyboard/KeyboardType/emojis`` keyboard type. An `EmptyView` is used as the default view, but KeyboardKit Pro unlocks an **EmojiKeyboard** that you can use.

The `toolbar` parameter defines the view that will be added above the keyboard. An ``AutocompleteToolbar`` will be used as the default view.

To use the standard views for all these views, you can just return `{ $0.view }`, or `{ params in params.view }` if you prefer more expressive code:

```swift
SystemKeyboard(
    controller: controller,
    buttonContent: { params in params.view },
    buttonView: { $0.view },
    emojiKeyboard: { $0.view },
    toolbar: { $0.view }
)
```

The various view builders provide even more parameters than just the default view. For instance, the button content and button view builders get the full layout item as well.

To customize or replace the standard content and item views for any item, just provide custom builders like this:

```swift
SystemKeyboard(
    controller: controller,
    buttonContent: { params in
        switch params.item.action {
        case .backspace: Image(systemName: "trash")
        default: params.view
        }
    },
    buttonView: { params in
        switch params.item.action {
        case .space: Text("This is true, empty space")
            .opacity(0)
            .frame(maxWidth: .infinity)
        default: params.view
        }
    },
    emojiKeyboard: { _ in Color.red },
    toolbar: { _ in Color.yellow }
)
```

In the code above, the backspace content is replaced with a trashbin and the entire spacebar is replaced by transparent text that takes up as much space as needed.

The system keyboard will place an ``AutocompleteToolbar`` topmost, if you explicitly tell it not to. Since the keyboard layout depends on the available keyboard width, you must pass in a `width`, if you don't want to use the current controller's width.

You can take a look at the source code of the various views in the library for inspiration.



## 👑 Pro features

KeyboardKit Pro unlocks powerful preview and emoji capabilities when you register a valid license key.


### Emojis

KeyboardKit Pro will make ``SystemKeyboard`` use an **Emojis.Keyboard** view (read more in <doc:Understanding-Emojis>) as the standard emoji keyboard. 

This means that by just registering a valid license key, your keyboard will automatically show an emoji keyboard when the ``KeyboardContext``.``KeyboardContext/keyboardType`` changes to ``Keyboard/KeyboardType/emojis``.

You can still provide a custom emoji keyboard if you want to use a custom one. 


### Preview

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
