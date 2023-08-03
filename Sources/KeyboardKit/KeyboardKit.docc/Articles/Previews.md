# Previews

This article describes the KeyboardKit preview engine.

KeyboardKit has `.preview` aliases for various state and service types, for instance ``KeyboardContext``.``KeyboardContext/preview`` and ``KeyboardActionHandler``.``KeyboardActionHandler/preview``.

If a view you want to preview use a type that has such a `.preview` alias, you can just use `.preview` instead of having to type the entire type name.


## How to use preview-specific state and services

Consider this view that takes an action handler as init parameter and looks for the keyboard context in the environment:

```swift
struct MyView {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    actionHandler: KeyboardActionHandler

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

In your preview, you can just inject ``KeyboardActionHandler/preview`` in the initializer and ``KeyboardContext/preview`` as an environment object:

```swift
struct MyView_Previews: PreviewProvider {

    static var previews: some View {
        MyView(actionHandler: .preview)
            .environmentObject(KeyboardContext.preview)
    }
}
```

Although using environment objects is convenient, KeyboardKit doesn't use environment objects since they make for hard to discover dependencies. As such, you will never have to inject environment objects to preview views in KeyboardKit.
