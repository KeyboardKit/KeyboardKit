# Previews

This article describes the KeyboardKit preview engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

SwiftUI previews are a great way to work on your project in Xcode without having to launch an app all the time. Just update your views and models, and the preview will update.

KeyboardKit has preview-specific services and state, that can be used in your previews. This makes it easy to set up and preview your keyboard-specific views directly in Xcode.

[KeyboardKit Pro][Pro] unlocks system keyboard and theme previews. Information about Pro features can be found at the end of this article.



## KeyboardPreviews namespace

KeyboardKit has a ``KeyboardPreviews`` namespace that contains preview-related services and state. The name doesn't match the group name, since "Previews" conflicts with SwiftUI.

For instance, the ``KeyboardContext`` ``KeyboardContext/preview`` can be used as a dummy context, and the ``KeyboardInputViewController`` ``KeyboardInputViewController/preview`` as a dummy input controller. 

These static, preview-specific services and state values simplify creating previews for views that use KeyboardKit-specific types.



## How to use preview-specific state and services

Consider this view, that takes a ``KeyboardActionHandler`` init parameter and looks for a ``KeyboardContext`` in the environment:

```swift
struct CustomView: View {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    private var actionHandler: KeyboardActionHandler

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        VStack {
            Button("Trigger backspace") {
                actionHandler.handle(.release, on: .backspace)
            }
            Button("Delete text in the proxu") {
                context.textDocumentProxy.deleteBackwards()
            }
        }
    }
}
```

To preview this view, just inject a ``KeyboardActionHandler/preview`` action handler in the initializer and a ``KeyboardContext/preview`` keyboard context as an environment object:

```swift
#Preview {

    CustomView(actionHandler: .preview)
        .environmentObject(KeyboardContext.preview)
}
```

You can take a look at the source code of the various views in the library for inspiration.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks powerful system keyboard previews, that can be used to preview different locales, configurations and themes.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("SystemKeyboardPreview") {
        
        KeyboardKit Pro unlocks a ``SystemKeyboardPreview`` that can be used to preview a full ``SystemKeyboard`` in many different ways, for instance by passing in a custom locale or theme
        
        @Row {
            @Column {
                ![System Keyboard Preview - Turkish](systemkeyboardpreview.jpg)
            }
            @Column {
                ![System Keyboard Preview - Theme](systemkeyboardpreview-theme.jpg)
            }
        }
        
        This preview is intended to be used in the main app, to for instance provide interactive previews in a settings screen. Since it draws a full keyboard with all interactions enabled, avoid displaying more one at a time.
    }
    
    @Tab("SystemKeyboardButtonPreview") {
        
        KeyboardKit Pro also unlocks a more lightweight ``SystemKeyboardButtonPreview`` that can be used to preview many buttons at once, for instance to preview multiple styles or ``KeyboardTheme``s at once:
        
        ![System Keyboard Button Preview](systemkeyboardbuttonpreview-350.jpg)

        Unlike the ``SystemKeyboardPreview``, this view just renders a very lightweight button preview, and is perfect for being used in style or theme pickers, to quickly visualize how certain button types look for a certain configuration, etc.

    }
}
