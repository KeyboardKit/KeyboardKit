# Audio Feedback

KeyboardKit has an `AudioFeedback` enum with these types:

*  `input`
*  `system`
*  `delete`
*  `custom`
*  `none`

You can enable global audio feedback by providing `StandardKeyboardActionHandler` with an `audioConfiguration`. The default configuration is `standard`. You can also trigger the various audio feedback types manually.


## Full Access

Audio feedback requires full access. Users must manually enable full access under system settings. 

