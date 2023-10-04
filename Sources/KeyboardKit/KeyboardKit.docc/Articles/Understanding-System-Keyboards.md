# Understanding System Keyboards

This article describes the KeyboardKit system keyboard.

As you may have noticed, Apple provides a very limited API to custom keyboard extensions. You have to implement much functionality from scratch, including the keyboard view itself.

KeyboardKit therefore has a ``SystemKeyboard`` that can be used to create alphabetic, numeric and symbolic keyboards that mimic the native iOS keyboard. It can be customized and styled to great extent, and automatically adjusts to the observable state you pass in. 

[KeyboardKit Pro][Pro] unlocks powerful system keyboard previews when you register a valid license key, and will also make it support emoji keyboards. Information about Pro features can be found at the end of this article.



## How to set up a system keyboard

KeyboardKit will by default use a standard ``SystemKeyboard``. If you just want to use this standard view, you don't have to do anything.

If you however want to customize the system keyboard, you must override ``KeyboardInputViewController/viewWillSetupKeyboard()`` and call any of the **setup** functions with a custom view.

```swift
class KeyboardController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in MyCustomToolbar() }
            )
        }
    }
}
```

The setup view builder provides an **unowned** controller reference to help avoiding memory leaks. Use it to access its state and services, and avoid passing it around. If you do, make sure to keep any additional references to it unowned.


## How to customize a system keyboard

A ``SystemKeyboard`` can be customized and styled to great extent. For instance, you can pass in custom keyboard layouts to it, and provide it with custom services and state to modify its behavior. 

The **buttonContent** and **buttonView** parameters can be used to customize the content or the entire view of any button.

The **emojiKeyboard** parameter defines the view that will be used for the ``Keyboard/KeyboardType/emojis`` keyboard type. An `EmptyView` is used by default, but KeyboardKit Pro unlocks an **EmojiKeyboard** that can be used instead.

The **toolbar** parameter defines a view that will be added above the keyboard. An ``AutocompleteToolbar`` will be used by default.

To use the standard views, just return `{ $0.view }`, or `{ params in params.view }` if you prefer more expressive code:

```swift
SystemKeyboard(
    controller: controller,
    buttonContent: { params in params.view },
    buttonView: { $0.view },
    emojiKeyboard: { $0.view },
    toolbar: { $0.view }
)
```

The various view builders provide more parameters than just the default view. For instance, the button content and button view builders get the full layout item as well.

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
    emojiKeyboard: { $0.view },
    toolbar: { $0.view }
)
```

In the code above, the backspace button content is replaced with a trashbin icon and the spacebar is replaced by transparent text.

The system keyboard will place an ``AutocompleteToolbar`` topmost, if you explicitly tell it not to. Since the keyboard layout depends on the available keyboard width, you must pass in a `width`, if you don't want to use the current controller's width.

You can take a look at the source code of the various views in the library for inspiration.

> Important: When customizing the toolbar, keep in mind that it's a good idea to have around 50 points padding above the keyboard, since input and action callouts may otherwise be cut off. This padding must increase if you style the callouts to be bigger. 



## 👑 Pro features

KeyboardKit Pro unlocks powerful preview and emoji capabilities when you register a valid license key.


### Emojis

KeyboardKit Pro will make ``SystemKeyboard`` use an **Emojis.Keyboard** view (read more in <doc:Understanding-Emojis>) as the standard emoji keyboard.

This means that by just registering a valid license key, your keyboard will automatically show an emoji keyboard when the ``KeyboardContext``.``KeyboardContext/keyboardType`` changes to ``Keyboard/KeyboardType/emojis``.

You can still provide a custom emoji keyboard if you want to use a custom one. If not, just remove the **emojiKeyboard** parameter when upgrading to KeyboardKit Pro.


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
