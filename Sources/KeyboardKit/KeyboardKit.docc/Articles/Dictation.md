# Dictation (PREVIEW)

This article describes the KeyboardKit dictation engine and how to use it.

In KeyboardKit, a ``DictationService`` can be used to perform dictation used to perform dictation if microphone access is available, while a ``KeyboardDictationService`` can be used to perform dictation from a keyboard extension.

KeyboardKit doesn't have any standard dictations services as it has for most other services. Instead, it will use a disabled service until you register a real one.

You can unlock a ``StandardDictationService`` and a ``StandardKeyboardDictationService`` with [KeyboardKit Pro][Pro] or create a custom implementation that uses custom logic.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## How to perform dictation from an app

You can use a ``DictationService`` to perform dictation within an app.

Before you can perform dictation, you must first add these keys to your app's `Info.plist`, otherwise the app will crash:

```
<key>NSMicrophoneUsageDescription</key>
<string>Describe why you need microphone access.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Describe why you need speech recognition.</string>
```

You can then start dictating by calling ``DictationService/startDictation(with:)`` and stop the operation with ``DictationService/stopDictation()``. Since dictation may stop at any time, the service doesnät return anything in ``stopDictation()``. Instead, each service implementation should describe how it provides the dictation result.

For instance, the ``StandardDictationService`` will continously update the observable ``DictationContext``, which means that you can easily display the current dictation state in your app.



## How to configure and perform dictation with a keyboard extension and its app

You can use a ``KeyboardDictationService`` to start dictating from a keyboard extension.

However, a keyboard extension can't perform dictation directly, since it can't access the microphone. This makes dictation a bit more complicated in a keyboard extension.

To perform dictation from a keyboard extension, the keyboard must set up shared state and open the app, which then must perform dictation and write the result to the shared state, then pop back to the keyboard extension which completes the operation by handling the result.

The ``KeyboardDictationService`` can then be used in both the keyboard extension and its app, to implement dictation:

* TBD

[KeyboardKit Pro][Pro] provides you with a ``KeyboardDictationService`` that implements this entire flow and just requires you to configure your app and keyboard correctly.



## 👑 Pro features

[KeyboardKit Pro][Pro] will unlock a ``StandardDictationService`` and a ``StandardKeyboardDictationService`` when you register a Gold license.

The ``StandardKeyboardDictationService`` implements the flow described above, and can be used by both the keyboard and the main app. It will use a ``StandardDictationService`` to perform the dictation in the app, then pop back to the main app. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
