# Essentials

This article describes the essential parts of KeyboardKit.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit extends Apple's native keyboard APIs and provides you with a lot more functionality. It lets you mimic a native iOS keyboard and tweak its style and behavior, or create completely custom keyboards.

KeyboardKit has a ``KeyboardView`` view that mimics the native iOS keyboard. It can be customized and styled to great extent, and lets you replace any key content or key view of any action.

👑 [KeyboardKit Pro][Pro] unlocks a lot of essential Pro features. Information about Pro features can be found further down.

See the <doc:Getting-Started-Article> article for more information on how to use the controller to set up and customize your keyboard extension.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespaces

KeyboardKit uses namespaces to make the API surface smaller, by nesting types in logical groups. KeyboardKit has namespaces like ``Keyboard``, ``KeyboardAction`` ``KeyboardLayout``, etc.

Namespaces don't contain protocols, or important types that are meant to be exposed as top-level types. This includes essential types like ``KeyboardInputViewController``, ``KeyboardContext``, etc., and important view components like ``KeyboardView``.

The ``Keyboard`` namespace contains a lot of essential, keyboard-related types and views. By typing ``Keyboard`` and `.`, Xcode will list all essential types within this namespace, like ``Keyboard/KeyboardType``, ``Keyboard/KeyboardCase``, ``Keyboard/ReturnKeyType``, etc.



## Controller

``KeyboardInputViewController`` is the most essential type in the library. Just make your **KeyboardController** inherit this class to get access to a bunch of additional ``KeyboardInputViewController/services``, ``KeyboardInputViewController/state``, and view lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboardView()``.

You can override many of the controller's open functions to customize its behavior. By delegating the responsibility of certain operations to its ``KeyboardInputViewController/services`` and ``KeyboardInputViewController/state``, you can avoid having to rely on the controller for most operations. 

KeyboardKit also has a ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in other platforms than UIKit.



## Context

KeyboardKit has a ``KeyboardContext`` that provides observable keyboard state that keeps the keyboard UI up to date. It has a ``KeyboardContext/textDocumentProxy`` reference, lets you get and set ``KeyboardContext/locale``, ``KeyboardContext/keyboardType``, etc. It also has auto-persisted ``KeyboardContext/settings-swift.property``. 

Other namespaces define separate contexts, like ``AutocompleteContext``, ``KeyboardCalloutContext``, ``DictationContext``, etc. They will all automatically update the keyboard view when modified, and provide namespace-specific settings.

KeyboardKit automatically creates instances of these classes and injects them into ``KeyboardInputViewController/state``, and syncs with the controller when needed.



## Settings

KeyboardKit has a ``Keyboard``-specific ``Keyboard/Settings`` type with auto-persisted keyboard settings. The ``KeyboardContext`` ``KeyboardContext/settings-swift.property`` property is used as the main settings instance within KeyboardKit.

The ``Keyboard/Settings`` class has a global ``Keyboard/Settings/store`` that is shared by all settings types and used to persist all settings. If you set up KeyboardKit with a ``KeyboardApp`` that defines an App Group, this store is set up to sync data between the app and its keyboard.

> Important: `@AppStorage` properties use the store that's available when they're first accessed. Make sure to set up a custom store BEFORE accessing any of these settings properties.



## Behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to define the keyboard's behavior. It's used by some services, like the standard ``KeyboardActionHandler``, to make behavior-based decisions.

KeyboardKit automatically creates an instance of ``Keyboard/StandardKeyboardBehavior`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, by implementing the procotol from scratch or by inheriting and customizing the standard behavior.



## Extensions

KeyboardKit extends native types like ``UIKit/UITextDocumentProxy`` with keyboard-specific functionality. See the extension section in documentation root article for more info.



## Keyboard View

KeyboardKit has a ``KeyboardView`` that mimics a native iOS keyboard. It can be used for alphabetic, numeric & symbolic keyboards, supports all supported locales, layouts, callouts, etc., and can be styled to great extent with styles & themes:

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

The view can be customized to great extent. You can pass in custom services & state, and replace any button or entire sub-component:

```swift
KeyboardView(
    controller: controller,             // You can pass in a controller, or specific states and services
    buttonContent: { $0.view },         // You can customize the content view of any button
    buttonView: { $0.view },            // You can customize the entire view of any button
    emojiKeyboard: { $0.view },         // You can customize the emoji keyboard, if any
    toolbar: { params in params.view }  // You can customize the toolbar above the keyboard
)
```

Just return `{ $0.view }` or `{ params in params.view }` to use the standard view, or return a custom view for any part of the keyboard. Each view builder provides you with view-related parameters with contextual information.

Note that some views, like the emoji keyboard and the collapsed content, requires KeyboardKit Pro. Without KeyboardKit Pro, you must manually implement what to show and when to show it.



## Keyboard View Capabilities

The ``KeyboardView`` will automatically: 

* Display the ``KeyboardContext/locale``, if unlocked by KeyboardKit Pro or manually implemented.
* Render the ``KeyboardLayout`` provided by the ``KeyboardLayoutService``.
* Style the keyboard with the styles provided by the ``KeyboardStyleService``.
* Display input and action callouts when the user interacts with the keyboard keys.
* Handle gestures, trigger actions, and handle all other complex keyboard operations.
* React to changes in ``KeyboardContext`` and its ``KeyboardContext/settings-swift.property``, as well as all other contexts & settings.

As a general rule, look in the various context and settings classes for things that you can modify. KeyboardKit will increase its use of environment values and view extensions over time, which will make things even more discoverable than they currently are.


## Keyboard View Size

The ``KeyboardView`` will by default take up as much space as it needs, and resize the keyboard extension frame accordingly. It will:

* Collapse when ``KeyboardContext/isKeyboardCollapsed`` is set, e.g. when connecting an external keyboard.
* Render a floating keyboard when ``KeyboardContext/isKeyboardFloating`` is active, e.g. when enabling it on iPad. 
* Dock to any edge that is applied with ``SwiftUICore/View/keyboardDockEdge(_:)``, which by default uses ``Keyboard/Settings/keyboardDockEdge``.

You can also modify the resulting keyboard size by changing the height of the ``KeyboardLayout`` rows.



## Other Essential Views

The ``Keyboard`` namespace has a lot of other standard views, styles, and view-related types to make it easy to build great keyboards.

@TabNavigator {
    
    @Tab("Button") {
        @Row {
            @Column {
                ![Keyboard Button](keyboard-buttonpreview)
            }
            @Column {
                The ``Keyboard`` namespace has a collection of ``Keyboard/Button`` views & styles that can be used to mimic all parts of a native keyboard.
                
                A ``Keyboard/Button`` renders the full button, while other views like ``Keyboard/ButtonShadow`` (not shown here) renders parts of it.
            }
        }
    }
    
    @Tab("CollapsedView") {
        @Row {
            @Column {
                ![Collapsed View](keyboard-collapsedview)
            }
            @Column {
                The ``Keyboard/CollapsedView`` can be used to render a collapsed view when ``KeyboardContext/isKeyboardCollapsed`` is true.
                
                KeyboardKit Pro automatically detects when an external keyboard is connected or disconnected, and update the state accordingly.
                
                The ``KeyboardView`` has a `collapsedContent` view builder that lets you specify which view to use as collapsed content.
            }
        }
    }
    
    @Tab("NextKeyboardButton") {
        @Row {
            @Column {
                ![Next Keyboard Button](keyboard-nextkeyboardbutton)
            }
            @Column {
                The ``Keyboard/NextKeyboardButton`` can be used to switch to the next keyboard on tap and to show a keyboard menu on long press.
            }
        }
    }
    
    @Tab("NumberPad") {
        @Row {
            @Column {
                ![Number Pad](keyboard-numberpad)
            }
            @Column {
                The ``Keyboard/NumberPad`` mimics a native number pad. ``KeyboardView`` will automatically show it for the ``Keyboard/KeyboardType/numberPad`` keyboard type.
            }
        }
    }
    
    @Tab("Toolbar") {
        ![Toolbar](keyboard-toolbar)
        
        The keyboard  ``Keyboard/Toolbar`` applies a minimum height to its content. KeyboardKit always adds a toolbar to the ``KeyboardView`` by default, to avoid callouts from being cut off, since a custom keyboard can't render any content outside of its frame.
    }
}

---

Most KeyboardKit views have a corresponding style & style modifier that can be applied to an individual view or an entire view hierarchy. You can e.g. apply a ``SwiftUICore/View/autocompleteToolbarStyle(_:)`` to the ``KeyboardView`` to customize the callout style within the view.

The ``KeyboardView`` however requires a ``KeyboardStyleService`` to style its buttons, since this requires dynamic styling on a per-button basis. You can however apply styles to the views you return in the ``KeyboardView``'s `buttonView` view builder.
    
---

    
## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional, powerful ``KeyboardView`` capabilities, including full support for all ``Foundation/Locale/keyboardKitSupported`` locales, a full-blown ``EmojiKeyboard``, input toolbars, powerful ``KeyboardViewPreview``s, etc.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Additional Views

KeyboardKit Pro unlocks additional ``Keyboard``-related views and utilities, that make it easier to create even more powerful keyboards:

@TabNavigator {
    
    @Tab("Localization") {
        @Row {
            @Column {
                ![A Swedish Keyboard](keyboardview-swedish)
            }
            @Column {
                KeyboardKit Pro unlocks localized services for all ``Foundation/Locale/keyboardKitSupported`` locales. This lets you create fully localized keyboards that automatically use correct buttons, autocomplete & callouts.
                
                The various license tiers unlock different amount of locales, where Gold unlocks all. See the <doc:Localization-Article> article for more information.
            }
        }
    }
    
    @Tab("Emoji Keyboard") {
        @Row {
            @Column { 
                ![Emoji Keyboard](emojikeyboard)
            }
            @Column { 
                KeyboardKit Pro unlocks an ``EmojiKeyboard`` that is added to ``KeyboardView`` when a valid license is registered.
                
                The emoji keyboard has support for categories, runtime version adjustments and skintones. Read more in the <doc:Emojis-Article> article.        
            }
        }
        
    }
    
    @Tab("Input Toolbar") {
        @Row {
            @Column { 
                ![Input Toolbar in iPad](keyboard-inputtoolbar-ipad)
            }
            @Column { 
                KeyboardKit Pro will automatically add an additional input toolbar above ``KeyboardView`` on large iPads, to fit the native keyboard.
                
                You can apply ``SwiftUICore/View/keyboardInputToolbarDisplayMode(_:)`` to the keyboard view to set whether to show or hide the toolbar, or to customize its buttons.
            }
        }
    }
    
    @Tab("Toggle Toolbar") {
        
        ![ToggleToolbar](keyboard-toggletoolbar)
        
        The ``Keyboard/ToggleToolbar`` can be used to toggle between two toolbars, e.g. to place a main menu "behind" the autocomplete toolbar.
        
        This view wraps itself in a ``Keyboard/Toolbar``, which means that it can also be styled with the ``SwiftUICore/View/keyboardToolbarStyle(_:)`` modifier.
    }
    
    @Tab("Bottom Row") {
        ![Bottom Row](keyboard-bottomrow)
        
        The keyboard ``Keyboard/BottomRow`` renders a bottom keyboard row with the same behavior as a full ``KeyboardView``. It can be used when you want to replace the rows above with a custom user interface.
    }
}


### Previews

KeyboardKit Pro also unlocks ``Keyboard``-related previews, that can be used to preview ``KeyboardView`` and ``Keyboard``.``Keyboard/Button`` for various configurations, locales, styles, themes, etc.

@TabNavigator {
    
    @Tab("KeyboardViewPreview") {
        KeyboardKit Pro unlocks a ``KeyboardViewPreview`` that can preview the ``KeyboardView`` for various locales, styles, themes, etc.

        @Row {
            @Column {
                ![KeyboardView Preview - Swedish](keyboardview-swedish)
            }
            @Column {
                ![KeyboardView Preview - Turkish](keyboardviewpreview)
            }
            @Column {
                ![KeyboardView Preview - Theme](keyboardviewpreview-theme)
            }
        }
    }
    
    @Tab("ButtonPreview") {
        @Row {
            @Column { 
                ![Keyboard Button Preview](keyboard-buttonpreview)
            }
            @Column { 
                KeyboardKit Pro unlocks a ``Keyboard/ButtonPreview`` that can be used to preview a ``Keyboard``.``Keyboard/Button``.
                
                This view is a lot more performant than the full ``KeyboardViewPreview``. Consider using it when you list multiple themes.
            }
        }
    }
}

These previews can be used in the main application, to show users how the keyboard will look for different settings, styles, themes, etc.

See the <doc:Previews-Article> article for more information.


---

## How to...

### Replace the standard keyboard view

KeyboardKit makes it super simple to replace or customize the standard ``KeyboardView``. The <doc:Getting-Started-Article> article has information about how you can use ``KeyboardInputViewController/viewWillSetupKeyboardView()`` to customize the keyboard view.


### Render unsupported keyboard types

While ``KeyboardView`` will render most ``Keyboard/KeyboardType``s, some don't have a standard visual representation. For instance setting the main ``KeyboardContext/keyboardType`` to ``Keyboard/KeyboardType/images`` has no effect if you use the standard ``KeyboardView``.

You can add support for unsupported keyboard types by creating a custom keyboard view that renders the standard ``KeyboardView`` (or a customized one) for supported keyboard types, and custom views for other types, for instance:

```swift
struct CustomKeyboardView: View {

    /// Passed in from the controller for convenience
    unowned var controller: KeyboardInputViewController

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        if context.keyboardType == .images {
            // Render a custom keyboard here
        } else {
            KeyboardView(
                state: controller.state,
                services: controller.services
            )
        }
    }
}
```

You can add a ``KeyboardAction/keyboardType(_:)`` action item to your keyboard to automatically switch to your custom keyboard when its tapped.


### Implement a custom keyboard type

You can implement a custom ``Keyboard/KeyboardType`` with the ``Keyboard/KeyboardType/custom(named:)`` type builder, then handle it by checking if the main  ``KeyboardContext/keyboardType`` matches your custom type:

```swift
extension Keyboard.KeyboardType {

    static var gifKeyboard: Keyboard.KeyboardType {
        return .custom(named: "gifKeyboard")
    } 
}
```

You can render a custom type just like you would any of the unsupported keyboard types, as demonstrated in the previous paragraph.
