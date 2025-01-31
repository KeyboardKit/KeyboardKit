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

KeyboardKit has a ``KeyboardView`` that mimics the native iOS keyboard. It can be used for alphabetic, numeric & symbolic keyboards, as well as completely custom ``KeyboardLayout``s, and can be used on all Apple platforms:

@Row {
    
    @Column {
        ![KeyboardView](keyboardview-english)
    }
    
    @Column {
        ![KeyboardView](keyboardview-swedish)
    }
    
    @Column {
        ![KeyboardView](keyboardview-styled)
    }
}

The ``KeyboardView`` will automatically conform to the current configurations and settings in the various context and settings classes, like ``KeyboardContext`` and ``KeyboardSettings``. It will also automatically apply gestures and callouts to its keys.

If you activate [KeyboardKit Pro][Pro], the ``KeyboardView`` will automatically support any of the locales in your license. Just set the ``KeyboardContext/locale`` and the keyboard will automatically be localized in that locale's language, and use a locale-specific ``KeyboardLayout``.


## Styles, Services & Settings vs. View Modifiers 

Since the ``KeyboardView`` has all the information it needs, it will set up most things for you. While you can customize each view, it will automatically apply gestures, styles, callouts, etc. based on the provided ``Keyboard/Services`` and ``Keyboard/State``.

So, while there are many view extensions, like ``SwiftUICore/View/keyboardDockEdge(_:)``, ``KeyboardView`` will automatically apply such extensions to its content, using the contextual state and settings. This means that it will override such view modifiers that you apply, except styles.

Styles are *meant* to be applied from the outside, and will be even more used in future versions of this SDK. Meanwhile, you will find that you can style many parts of the keyboard with both view modifiers and a custom ``KeyboardStyleService``.

In general, use ``Keyboard/Services``, ``Keyboard/State``, and ``KeyboardSettings`` to customize the ``KeyboardView`` and use view modifiers for styles. 



## How to 

### ...customize the keyboard

The ``KeyboardView`` can be customized to great extent. You can pass in custom services & state, and replace any button or sub-view:

```swift
KeyboardView(
    controller: controller,             // You can pass in a controller OR specific states and services
    buttonContent: { $0.view },         // You can customize the content view of any button
    buttonView: { $0.view },            // You can customize the entire view of any button
    collapsedView: { $0.view },         // You can customize the collapsed keyboard view
    emojiKeyboard: { $0.view },         // You can customize the emoji keyboard, if any
    toolbar: { params in params.view }  // You can customize the toolbar above the keyboard
)
```

Just return `{ $0.view }` or `{ params in params.view }` to use the standard view, or return a custom view for any part of the keyboard, using the contextual parameters that each view builder provides.

The standard emoji keyboard and collapsed view are unlocked by [KeyboardKit Pro][Pro]. You can however inject any custom views you like.


### ...customize the keyboard behavior

The easiest way to customize the behavior of the keyboard is to inherit ``KeyboardAction/StandardActionHandler``, then customize the behavior of any ``Keyboard/Gesture`` on any ``KeyboardAction`` by overriding the various service functions.

See the <doc:Actions-Article> article for more information.


### ...customize the keyboard callouts

The easiest way to customize the secondary callout actions that are used for a specific key is to inherit ``KeyboardCallout/StandardCalloutService``, then customize which actions to return any keys by overriding the various service functions. 

See the <doc:Callouts-Article> article for more information.


### ...customize the keyboard layout

The easiest way to add, replace and remove keys is to inherit ``KeyboardLayout/StandardLayoutService`` and customize the ``KeyboardLayout`` by overriding the various service functions. 

See the <doc:Layout-Article> article for more information.


### ...customize the keyboard design

The easiest way to adjust the ``KeyboardView`` design is to inherit ``KeyboardStyle/StandardStyleService`` and customize the various styles by overriding the various service functions. You can change background and foreground colors, fonts, etc. for any part of the keyboard. 

See the <doc:Styling-Article> and <doc:Themes-Article> articles for more information.


### ...customize the keyboard size

The ``KeyboardView`` will by default take up as much space as it needs, and resize the keyboard extension frame accordingly. It will:

* Collapse when ``KeyboardContext/isKeyboardCollapsed`` is set, e.g. when connecting an external keyboard.
* Collapse when an external keyboard is connected, if ``KeyboardSettings/isKeyboardAutoCollapseEnabled`` is set.
* Dock to any horizontal edge of the screen when ``KeyboardSettings/keyboardDockEdge`` is set.
* Render as a floating keyboard when ``KeyboardContext/isKeyboardFloating`` is set (iPad only).
* Render custom sizes for any keys, based on the size information in the ``KeyboardLayout``.

See the <doc:Essentials> article and various namespace articles for more information.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
