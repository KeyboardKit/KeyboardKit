# Feedback

This article describes the KeyboardKit feedback engine.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

Feedback is an important part of the typing experience, where a keyboard can trigger audio and haptic feedback when a user taps on a key or performs certain actions.

In KeyboardKit, audio and haptic feedback can be triggered with a ``KeyboardActionHandler`` or by triggering an ``AudioFeedback`` or ``HapticFeedback`` type directly.



## Audio feedback

KeyboardKit has an ``AudioFeedback`` enum that defines various standard audio feedback types, like ``AudioFeedback/input``, ``AudioFeedback/system``, ``AudioFeedback/delete``, etc.

This enum also serves as a namespace for other audio feedbac-related types like ``AudioFeedback/Configuration`` and ``AudioFeedback/Engine``.



## Haptic feedback

KeyboardKit has an ``HapticFeedback`` enum that defines various haptic feedback types, like ``HapticFeedback/error``, ``HapticFeedback/success``, and ``HapticFeedback/warning``. 

This enum also serves as a namespace for types like ``HapticFeedback/Configuration`` and ``HapticFeedback/Engine``.



## How to trigger audio & haptic feedback

You can trigger any audio feedback with ``AudioFeedback/trigger()``, and any haptic feedback with ``HapticFeedback/trigger()``:

```swift
AudioFeedback.input.trigger()
HapticFeedback.lightImpact.trigger()
```

You can also trigger feedback with a ``KeyboardActionHandler``, using ``KeyboardActionHandler/triggerFeedback(for:on:)``. You can either use the feedback configuration described below to customize the feedback, or create a custom action handler. 



## How to configure feedback

KeyboardKit has an observable ``FeedbackConfiguration`` that can be used to configure feedback for various actions. 

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``. You can use this instance to configure feedback:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = state.feedbackConfiguration 
        config.audio = .disabled
        config.audio.input = .custom(id: 1329)
        config.haptic = .minimal
    }
}
```

Since the configuration is observable, any changes will automatically cause the keyboard to update, e.g. if you have feedback toggles.



## How to define custom audio feedback

Since ``AudioFeedback`` uses **AudioServices** to play audio, you can use any system audio ID (see [this website](https://iphonedev.wiki/index.php/AudioServices) for info) as feedback. 

For instance, this is a way to define a custom sound:

```swift
extension AudioFeedback {

    static let sentMessage = .custom(id: 1004)
}
```

You can also implement a custom action handler to trigger feedback in a completely different way. See <doc:Actions-Article> for more information.
