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

[KeyboardKit Pro][Pro] unlocks keyboard and theme previews. Information about Pro features can be found at the end of this article.



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

[KeyboardKit Pro][Pro] unlocks powerful keyboard previews that can be used to preview different locales, configurations and themes.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("KeyboardViewPreview") {
        
        KeyboardKit Pro unlocks a ``KeyboardViewPreview`` that can be used to preview a full ``KeyboardView`` in many different ways, for instance by passing in a custom locale or theme
        
        @Row {
            @Column {
                ![KeyboardView Preview - Turkish](keyboardviewpreview)
            }
            @Column {
                ![KeyboardView Preview - Theme](keyboardviewpreview-theme)
            }
        }
        
        This preview is intended to be used in the main app, to for instance provide interactive previews in a settings screen. Since it draws a full keyboard with all interactions enabled, avoid displaying more one at a time.
        
        If you want to display several previews at once, consider using the  more lightweight ``KeyboardViewButtonPreview`` instead:
        
        @Row {
            @Column {}
            @Column(size: 2) {
                ![Keyboard View Button Preview](keyboardviewbuttonpreview)
            }
            @Column {}
        }
        
        Unlike ``KeyboardViewPreview``, this view renders a very lightweight button preview. It's for instance used in the theme ``KeyboardTheme/Shelf``, to display a button preview for all available themes:
        
        @Row {
            @Column {}
            @Column(size: 2) {
                ![Theme Shelf](themeshelf)
            }
            @Column {}
        }
    }
}
