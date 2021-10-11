# Audio Feedback

KeyboardKit defines system audio types and ways to play them.


## System Audio

KeyboardKit has a `SystemAudio` enum with these types:

*  `input` - represents the sound of an input key.
*  `system` - represents the sound of a system key.
*  `delete` - represents the sound of a delete key.
*  `custom` - represents a custom sound.
*  `none` - represents no sound.

You can play these sounds directly, using the `play()` function.


## Configuration

KeyboardKit has an `AudioFeedbackConfiguration` type that lets you configure audio feedback.

KeyboardKit defines a few predefined configurations:

* `enabled` - enables all audio feedback 
* `noFeedback` - disables all audio feedback
* `standard` - is the standard configuration (`enabled`)

You can register audio feedback by registering a custom `feedback handler`.


## Full Access

Audio feedback requires full access. 

