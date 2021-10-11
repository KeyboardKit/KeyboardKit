# Previews

KeyboardKit defines a bunch of preview-specific types that simplify previewing keyboard views in SwiftUI.


## Services

Most services have a `Preview<ProtocolName>` and static `.preview` property that can be used in SwiftUI previews.

Note that if a view depends on multiple services, at least one parameter must not use the `.preview` property.


## Context

Most contexts have a static `.preview` property that can be used in SwiftUI previews.


## Preview Assets

KeyboardKit providers color, image and text resources that are embedded within the Swift Package and require the `.module` bundle to be available.

However, SwiftUI previews currently can't access these resources, since the `.module` bundle isn't defined in previews. Trying to access these resources will cause these previews to crash. 

Until this is solved in SwiftUI and SPM, call `KeyboardPreviews.enable()` in each preview to use fake colors and texts that don't break the preview.
