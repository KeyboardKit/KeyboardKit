# Previews

This article describes the KeyboardKit preview engine.

KeyboardKit has `.preview` aliases for various state and service types, for instance ``KeyboardContext``.``KeyboardContext/preview`` and ``KeyboardActionHandler``.``KeyboardActionHandler/preview``.


## How to use preview-specific state and services

Consider this view that takes a ``KeyboardActionHandler`` as init parameter and looks for a ``KeyboardContext`` in the environment:

```swift
struct MyView {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    var actionHandler: KeyboardActionHandler

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

In your preview, you can just inject a ``KeyboardActionHandler/preview`` action handledr in the initializer and a ``KeyboardContext/preview`` keyboard context as an environment object:

```swift
struct MyView_Previews: PreviewProvider {

    static var previews: some View {
        MyView(actionHandler: .preview)
            .environmentObject(KeyboardContext.preview)
    }
}
```
