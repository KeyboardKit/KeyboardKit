# Essentials - KeyboardView

This article describes the essential ``KeyboardView`` and how to use and configure it.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}


## Keyboard View

KeyboardKit has a ``KeyboardView`` that mimics the native iOS keyboard. It can be used for alphabetic, numeric & symbolic keyboards, as well as completely custom ``KeyboardLayout``s:

@Row {
    
    @Column {
        ![KeyboardView](keyboardview-english)
    }
    
    @Column {
        ![KeyboardView](keyboardview-swedish)
    }
    
    @Column {
        ![KeyboardView](keyboardview-theme)
    }
}

``KeyboardView`` will automatically observe and adapt to the current configurations and settings in the various context classes, and can render all localized keyboards that are unlocked by [KeyboardKit Pro][Pro].


## How to 

### ...customize the keyboard

The ``KeyboardView`` will set up most things for you, like applying gestures, styles, callouts, etc. based on the ``Keyboard/Services`` and ``Keyboard/State``. You can customize any view in the keyboard, apply view modifiers to override the values that  ``KeyboardView`` will otherwise use, etc. 

For instance, you can customize any button content or button view by using the ``KeyboardView`` init arguments, or use the ``SwiftUICore/View/keyboardButtonStyle(builder:)`` view modifier to customize the button style of any button:

```swift
KeyboardView(
    controller: controller,             // You can pass in a controller OR specific states and services
    buttonContent: { $0.view },         // You can customize the content view of any button
    buttonView: { $0.view },            // You can customize the entire view of any button
    collapsedView: { $0.view },         // You can customize the collapsed keyboard view
    emojiKeyboard: { $0.view },         // You can customize the emoji keyboard, if any
    toolbar: { params in params.view }  // You can customize the toolbar above the keyboard
)
.keyboardButtonStyle { params in
    // You can also customize the button style for any action without customizing the view.
}
```

In general, use the various ``Keyboard/State`` contexts and their auto-persisted settings to control the ``KeyboardView``, and use the view builders and apply view modifiers to make app-specific customizations.

The standard emoji keyboard and collapsed view are unlocked by [KeyboardKit Pro][Pro]. You can however inject any custom views you like.


### ...customize the keyboard behavior

The easiest way to customize the behavior of the keyboard is to inherit ``KeyboardAction/StandardActionHandler``, then customize the behavior of any ``Keyboard/Gesture`` on any ``KeyboardAction`` by overriding the various service functions, like ``KeyboardActionHandler/handle(_:on:)``.

See the <doc:Actions-Article> article for more information.


### ...customize the keyboard callouts

The easiest way to customize the keyboard callout actions is to apply a ``SwiftUICore/View/keyboardCalloutActions(_:)`` view modifier to the view.

See the <doc:Callouts-Article> article for more information.


### ...customize the keyboard layout

The easiest way to add, replace and remove keys is to inherit ``KeyboardLayout/StandardLayoutService`` and customize the ``KeyboardLayout`` by overriding the various service functions. 

See the <doc:Layout-Article> article for more information.


### ...customize the keyboard design

The easiest way to style a ``KeyboardView`` is to apply style view modifiers like ``SwiftUICore/View/keyboardButtonStyle(builder:)`` to the view. 

See the <doc:Styling-Article> and <doc:Themes-Article> articles for more information.


### ...customize the keyboard size

The ``KeyboardView`` will by default take up as much space as it needs, and resize the keyboard extension frame accordingly. It will:

* Collapse when ``KeyboardContext/isKeyboardCollapsed`` is set, e.g. when connecting an external keyboard.
* Collapse when an external keyboard is connected, if ``KeyboardSettings/isKeyboardAutoCollapseEnabled`` is set.
* Dock to any horizontal edge of the screen when ``KeyboardSettings/keyboardDockEdge`` is set.
* Render as a floating keyboard when ``KeyboardContext/isKeyboardFloating`` is set (iPad only).
* Render custom sizes for any keys, based on the size information in the ``KeyboardLayout``.

See the <doc:Essentials-Article> article and various namespace articles for more information.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
