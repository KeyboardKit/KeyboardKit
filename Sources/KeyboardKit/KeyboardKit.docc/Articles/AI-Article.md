# AI Support

This article describes the KeyboardKit AI support capabilities.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Apple's native keyboard APIs lack many features that are needed by popular AI-based features, for instance to read an entire document to perform tasks like spellchecking & proofreading, or to let users type text prompts directly within the keyboard.

👑 [KeyboardKit Pro][Pro] unlocks these capabilities to make it possible to read the full document and type in a text field within the keyboard.


## Full Document Reader

Apple's native text document proxy doesn't return all the text within the document. It instead cuts off the available text at any time, e.g. at the previous or next paragraph. This makes it hard to provide AI-based features that require more context.

KeyboardKit Pro therefore unlocks ways to read **all** text from the proxy, using ``UIKit/UITextDocumentProxy/fullDocumentContext(config:)`` proxy extensions that reads the full document content by moving the input cursor in intricate ways.

```swift
let proxy = keyboardContext.textDocumentProxy
let result = try await proxy.fullDocumentContext()
```

This will provide you with all the text before and after the text input cursor, as well as an aggregate of all the available text. See the <doc:Proxy-Article> article for more information.


## Next Word Prediction (BETA)

Apple's on-device text prediction utilities stopped supporting next word prediction in iOS 16. KeyboardKit Pro therefore unlocks ways to let the local autocomplete service perform next word prediction via 3rd party AI services.

The easiest way to enable next word prediction, is to add a ``Autocomplete/NextWordPredictionRequest`` to your ``KeyboardApp`` configuration:

```swift
extension KeyboardApp {

    static var keyboardKitDemo: KeyboardApp {
        KeyboardApp(
            ...
            autocomplete: .init(
                nextWordPredictionRequest: .claude(apiKey: "your-key-here")
            )
        )
    }
}
```

KeyboardKit Pro has support for Claude and OpenAI. See the <doc:Autocomplete-Article> article for more information and important considerations.


## Text Input Support

Apple's native input controller & text document proxy don't let you type in text fields within the keyboard. Instead, text will be sent to the main app even if a text field in the keyboard is focused. This makes it hard to let user perform AI-based prompting within the keyboard.

KeyboardKit Pro unlocks ways to let users type within a keyboard extension, by routing text input from the main app to text fields within the keyboard, without the need for any additional code.

```swift
extension MyView: View {

    @EnvironmentObject var context: KeyboardContext

    @State var text = ""

    var body: some View {
        KeyboardTextField(
            text: $text, 
            keyboardContext: context
        )
    }
}
```

See the <doc:Text-Input-Article> article for more information.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
