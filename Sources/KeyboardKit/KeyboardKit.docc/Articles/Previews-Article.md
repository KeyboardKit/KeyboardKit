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

[KeyboardKit Pro][Pro] unlocks powerful keyboard preview components. Information about Pro features can be found at the end of this article.



## Preview-specific state and services 

KeyboardKit adds preview-specific shorthand for all services and states. For instance, ``KeyboardContext`` has a ``KeyboardContext/preview`` context, the ``KeyboardInputViewController`` has a ``KeyboardInputViewController/preview`` controller, etc. 

These preview-specific values make it easy to pass in and apply preview-specific implementations in SwiftUI previews. 

For instance, consider this custom view, which relies on a ``KeyboardActionHandler`` and a ``KeyboardContext``:

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

To preview the view, you can just pass in a ``KeyboardActionHandler/preview`` action handler in the initializer and inject a ``KeyboardContext/preview`` context into the environment:

```swift
#Preview {

    CustomView(actionHandler: .preview)
        .environmentObject(KeyboardContext.preview)
}
```

You can take a look at the source code of the various views in the library for inspiration.



## 👑 KeyboardKit Pro

### Preview Components

[KeyboardKit Pro][Pro] unlocks powerful keyboard previews that can be used to preview different locales, configurations and themes, like the ``KeyboardViewPreview``, the ``Keyboard``.``ButtonPreview``, etc.

See the <doc:Essentials> article for more information about these preview components, screenshots, etc.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
