# Essentials

This article describes the essential parts of KeyboardKit.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

This article describes essential types, models, and views that KeyboardKit provides. See the <doc:Getting-Started-Article> guide for information on how to set up your main app and keyboard extension for KeyboardKit.

👑 [KeyboardKit Pro][Pro] unlocks a lot of additional, essential Pro features. Information about Pro features can be found further down.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespaces

KeyboardKit uses namespaces nest types into logical groups, like ``Keyboard``, ``KeyboardAction`` ``KeyboardLayout``, etc. This helps making the library surface smaller and easier to navigate.

Namespaces don't contain protocols or important types that are meant to be exposed as top-level types. This includes important types like ``KeyboardInputViewController``, ``KeyboardContext``, etc., and important views, like ``KeyboardView``.

The ``Keyboard`` namespace contains many essential, keyboard-related types and views. By typing ``Keyboard`` and `.`, Xcode will list all types in this namespace, like ``Keyboard/KeyboardType``, ``Keyboard/Button``, etc.



## Models

The ``Keyboard`` namespace contains many essential keyboard models that are used by many other features, for instance these ones:

* ``Keyboard/AddedLocale``
* ``Keyboard/AutocapitalizationType``
* ``Keyboard/BackspaceRange``
* ``Keyboard/Button``
* ``Keyboard/ButtonStyle``
* ``Keyboard/Diacritic``
* ``Keyboard/DockEdge``
* ``Keyboard/Gesture``
* ``Keyboard/InputToolbarDisplayMode``
* ``Keyboard/KeyboardCase``
* ``Keyboard/KeyboardType``
* ``Keyboard/LayoutType``
* ``Keyboard/ReturnKeyType``
* ``Keyboard/SpaceDragSensitivity``
* ``Keyboard/SpaceLongPressBehavior``
* ``Keyboard/SpaceMenuType``

Many of these models, like ``Keyboard/LayoutType``, could be considered to belong in other namespaces, but are placed in ``Keyboard`` since they are used by core features and describe essential parts of the keyboard.


## Controller

``KeyboardInputViewController`` is the most essential type in the library. See the <doc:Getting-Started-Article> guide on how to use it to access a bunch of additional ``KeyboardInputViewController/services``, ``KeyboardInputViewController/state``, and lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboardView()``.

You can override controller functions to customize its behavior. By delegating the responsibility of certain operations to its ``KeyboardInputViewController/services`` and ``KeyboardInputViewController/state``, you can avoid having to rely on the controller for most operations. 

KeyboardKit also has a ``KeyboardController`` that aims to make it easier to use KeyboardKit in platforms that don't support UIKit.



## Context

KeyboardKit has a ``KeyboardContext`` that provides observable keyboard state. It has a ``KeyboardContext/textDocumentProxy`` reference, lets you get and set ``KeyboardContext/locale``, ``KeyboardContext/keyboardType``, etc. and also has auto-persisted ``KeyboardContext/settings-swift.property``.

Other namespaces define separate contexts, like ``AutocompleteContext``, ``KeyboardCalloutContext``, ``DictationContext``, etc. They all update the keyboard view when they're modified, and provide namespace-specific properties and settings.

KeyboardKit automatically creates instances of these classes and injects them into ``KeyboardInputViewController/state``, and syncs with the controller when needed.



## Settings

KeyboardKit has a ``Keyboard``-specific ``KeyboardSettings`` type with auto-persisted keyboard settings. It has a global ``KeyboardSettings/store`` that is shared by all settings types and used to persist settings.

The ``KeyboardContext`` ``KeyboardContext/settings-swift.property`` property is used as the standard settings instance in KeyboardKit, as are the other contexts. If you set up KeyboardKit with a ``KeyboardApp`` that defines an App Group, this store will sync data between the app and its keyboard.

> Important: `@AppStorage` properties use the store that's available when they're first accessed. Make sure to set up a custom store BEFORE accessing any of these settings properties.



## Behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to define the keyboard's behavior. It's used by some services, like the standard ``KeyboardActionHandler``, to make behavior-based decisions.

KeyboardKit automatically creates an instance of ``Keyboard/StandardKeyboardBehavior`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, by implementing the procotol from scratch or by inheriting and customizing the standard behavior.



## Native Type Extensions

KeyboardKit extends native types like ``UIKit/UIInputViewController`` and ``UIKit/UITextDocumentProxy`` with more functionality. See the extension section in documentation root article for more info.



## Keyboard View

KeyboardKit has a ``KeyboardView`` that mimics the native iOS keyboard. It can be used for alphabetic, numeric & symbolic keyboards, supports all supported locales, layouts, callouts, etc., and can be used on all Apple platforms:

@Row {
    
    @Column {
        ![KeyboardView](keyboardview-english)
    }
    
    @Column {
        ![KeyboardView](keyboardview-theme)
    }
}

This component is so important, that it has a dedicated <doc:Essentials-KeyboardView> article that describes how to use and customize it.



## Views

The ``Keyboard`` namespace has a lot of other standard views, styles, and view-related types to make it easy to build great keyboards.

@TabNavigator {
    
    @Tab("Button") {
        @Row {
            @Column {
                ![Keyboard Button](keyboard-buttonpreview)
            }
            @Column {
                The ``Keyboard`` namespace has ``Keyboard/Button`` views & styles that can be used to mimic all parts of a native keyboard.
                
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
                A ``Keyboard/CollapsedView`` can be used if ``KeyboardContext/isKeyboardCollapsed`` is enabled, to show a compact toolbar.
                
                The ``KeyboardView`` has a `collapsedContent` view builder that lets you specify which view to use as collapsed content.
                
                KeyboardKit Pro automatically detects when an external keyboard is connected, and update this state accordingly.
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
                
                The ``KeyboardView`` will automatically render a next keyboard switcher for the ``KeyboardAction/nextKeyboard`` action.
            }
        }
    }
    
    @Tab("NumberPad") {
        @Row {
            @Column {
                ![Number Pad](keyboard-numberpad)
            }
            @Column {
                The ``Keyboard/NumberPad`` mimics a native number pad, which can be used for pure numeric inputs.
                
                ``KeyboardView`` will automatically use this view for the ``Keyboard/KeyboardType/numberPad`` keyboard type.
            }
        }
    }
    
    @Tab("Toolbar") {
        @Row {
            @Column {
            ![Toolbar](keyboard-toolbar)
            }
            @Column {
        
            The keyboard  ``Keyboard/Toolbar`` applies a minimum height to its content.
            
            The ``KeyboardView`` always renders a toolbar by default, to avoid callouts from being cut off.
            
            You *can* to remove the toolbar, but it's not recommended, since a custom keyboard can't render content outside of its frame.
            }
        }
    }
}


## Styling

Most ``Keyboard`` views have a style view modifier. You can e.g. apply an ``SwiftUICore/View/autocompleteToolbarStyle(_:)`` to ``KeyboardView`` to customize the autocomplete toolbar style, and ``SwiftUICore/View/keyboardButtonStyle(builder:)`` to customize the button style.
    
---

    
## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional, powerful ``KeyboardView`` capabilities, including full support for all ``Foundation/Locale/keyboardKitSupported`` locales, a full-blown ``EmojiKeyboard``, input toolbars, powerful ``KeyboardViewPreview``s, etc.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Pro Views

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
                ![Emoji Keyboard](keyboardview-emojis)
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
        @Row {
            @Column {
                ![KeyboardView Preview - Swedish](keyboardview-swedish)
            }
            @Column {
                KeyboardKit Pro unlocks a ``KeyboardViewPreview`` that can be used to preview a ``KeyboardView`` for various locales, styles, etc.
                
                This preview is intended to be used in the main app, for instance to show the effect of changing settings or styles.
                
                Note that this view renders a full keyboard, so it's not performant enough to preview many keyboards at once. For these cases, use a ``Keyboard/ButtonPreview`` instead.
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
                
                This preview is intended to be used in the main app, for instance to list themes in a picker.
                
                This view is more performant than ``KeyboardViewPreview``.
            }
        }
    }
}

See the <doc:Previews-Article> article for more information.


---

## How to...

### ...replace the standard keyboard view

KeyboardKit makes it super simple to customize or replace the standard ``KeyboardView``. The <doc:Getting-Started-Article> guide has information that shows you how to do this with just a few lines of code.


### ...render unsupported keyboard types

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


### ...implement a custom keyboard type

You can implement a custom ``Keyboard/KeyboardType`` with the ``Keyboard/KeyboardType/custom(named:)`` type builder, then handle it by checking if the main  ``KeyboardContext/keyboardType`` matches your custom type:

```swift
extension Keyboard.KeyboardType {

    static var gifKeyboard: Keyboard.KeyboardType {
        return .custom(named: "gifKeyboard")
    } 
}
```

You can render a custom type just like you would any of the unsupported keyboard types, as demonstrated in the previous paragraph.
