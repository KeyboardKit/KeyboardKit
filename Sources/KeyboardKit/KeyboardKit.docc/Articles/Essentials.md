# Essentials

This article describes essential parts of the KeyboardKit library.

Apple's native keyboard APIs are very limited. You have to implement much from scratch, including the keyboard view itself.

KeyboardKit therefore provides a bunch of essential functionality, extends the text document proxy to make it much more capable, and lets you use SwiftUI instead of UIKit.

KeyboardKit also has a ``SystemKeyboard`` that mimics the native iOS keyboard. It can be customized and styled to great extent.

[KeyboardKit Pro][Pro] unlocks a lot of essential pro features. Information about Pro features can be found at the end of this article.



## Keyboard namespace

KeyboardKit has a ``Keyboard`` namespace with essential types, like ``Keyboard/AutocapitalizationType``, ``Keyboard/Case``, ``Keyboard/ReturnKeyType``, and much more.

The namespace doesn't contain protocols, open classes, or types that are meant to be exposed at the top-level.



## Keyboard input view controller

The ``KeyboardInputViewController`` is the most essential type in the library. Make your **KeyboardController** inherit this base class instead of **UIInputViewController**, to get access to a bunch of additional capabilities.

KeyboardKit also has an abstract ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in platforms that don't support UIKit. This is however not fully implemented yet.



## Keyboard context

KeyboardKit has an observable ``KeyboardContext`` class that provides information about the keyboard, a reference to the current ``KeyboardContext/textDocumentProxy``, and lets you get and set the current ``KeyboardContext/locale``, ``KeyboardContext/keyboardType``, etc.

You can use the context to affect the keyboard. For instance, setting the ``KeyboardContext/locale`` will automatically update the ``SystemKeyboard``.

KeyboardKit automatically creates an instance of this class and binds it to ``KeyboardInputViewController/state``, then syncs it with the controller whenever needed.



## Keyboard behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to determine certain keyboard behaviors. It's used by e.g. the ``StandardKeyboardActionHandler`` to make some decisions.

KeyboardKit automatically creates an instance of this class and binds it to ``KeyboardInputViewController/services``. You can modify or replace it at any time.



## System keyboard

KeyboardKit has a ``SystemKeyboard`` that can be used to create alphabetic, numeric and symbolic keyboards that mimic the native iOS keyboard. It can be customized and styled to great extent, and automatically adjusts itself to the observable state you pass in. 

KeyboardKit will by default use a standard ``SystemKeyboard``. If you just want to use this standard view, you don't have to do anything.

If you however want to customize the system keyboard, or use a custom view, just override ``KeyboardInputViewController/viewWillSetupKeyboard()`` and call any of the **setup** functions with the view you want to use.

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


### How to customize a system keyboard

A ``SystemKeyboard`` can be customized to great extent. You can for instance pass in custom services and state to modify its behavior.

Modifying the various views is equally easy:

* The **buttonContent** parameter can be used to customize the content view of a button.
* The **buttonView** parameter can be used to customize the entire view of a button.
* The **emojiKeyboard** parameter can be used to customize the **.emojis** keyboard view.
* The **toolbar** parameter can be used to customize the toolbar that is added above the keyboard.

The **emojiKeyboard** will by default use an empty placeholder, which will remove the emoji button from the keyboard. KeyboardKit Pro unlocks an **EmojiKeyboard** and uses it by default.

To use the standard views, just return `{ $0.view }`, or `{ params in params.view }` if you prefer more expressive code:

```swift
SystemKeyboard(
    controller: controller,
    buttonContent: { $0.view },
    buttonView: { $0.view },
    emojiKeyboard: { $0.view },
    toolbar: { $0.view }
)
```

The various view builders provide more parameters than just the default view. For instance, the button content and button view builders provide you with the full layout item as well.

To customize or replace the standard content and item views for any layout item, just provide custom view builders like this:

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

> Important: When customizing the toolbar, keep in mind that it's a good idea to have around 50 points padding above the keyboard, since input and action callouts may otherwise be cut off. This padding must increase if you style the callouts to be bigger. 



## 👑 Pro features

KeyboardKit Pro unlocks powerful preview and emoji capabilities for the system keyboard.


### Emojis

KeyboardKit Pro will make ``SystemKeyboard`` use an **EmojisKeyboard** view (read more in <doc:Understanding-Emojis>) as emoji keyboard.

This means that by just registering a valid license key, your keyboard will automatically show an emoji keyboard when the ``KeyboardContext``.``KeyboardContext/keyboardType`` changes to ``Keyboard/KeyboardType/emojis``.

You can still provide a custom emoji keyboard if you want to use a custom one. If not, just remove the **emojiKeyboard** parameter when upgrading to KeyboardKit Pro.


### System Keyboard Preview

KeyboardKit Pro unlocks a **SystemKeyboardPreview** that can be used to preview different configurations and themes, e.g. in your main app's settings screen.

It's a regular view that you can place anywhere:

```swift
struct MyView: View {

    var body: some View {
        SystemKeyboardPreview(theme: try? .candyShop)
    }
}
```

You can use **.asScreenHeader(withScreenContent:)** to convert it to a screen header that pins to the top of the screen and places the provided content below itself.

```swift
struct MyView: View {

    var body: some View {
        SystemKeyboardPreview(theme: try? .candyShop)
            .asScreenHeader {
                List {
                    ForEach((1...100), id: \.self) {
                        Text("\($0)")
                    }
                }
            }
    }
}
```

Since this view renders with full interation, you shouldn't use many previews on the same screen, as this will reduce performance.

To preview many styles or themes at once, you can the more lightweight **SystemKeyboardButtonPreview** which renders more lightweight button previews.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
