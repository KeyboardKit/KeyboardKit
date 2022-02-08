# Previews

KeyboardKit defines a bunch of preview-specific types that simplify previewing keyboard views in SwiftUI.


## Preview Mode

SwiftUI previews currently can't access resources in other libraries, since the `.module` bundle isn't defined in previews. Trying to access these resources will cause these previews to crash. 

Until this is solved, you can use `KeyboardPreviews.enable()` to make KeyboardKit use fake resources that don't make the preview crash.


## Context and services

Many contexts and services have static `.preview` properties that can be used in SwiftUI previews, to simplify previewing its views.
