//
//  KeyboardInputViewController+Services.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
public extension KeyboardInputViewController {
    
    @available(*, deprecated, renamed: "services.actionHandler")
    var keyboardActionHandler: KeyboardActionHandler {
        get { services.actionHandler }
        set { services.actionHandler = newValue }
    }
    
    @available(*, deprecated, renamed: "services.layoutProvider")
    var keyboardLayoutProvider: KeyboardLayoutProvider {
        get { layoutProvider }
        set { layoutProvider = newValue }
    }
    
    @available(*, deprecated, renamed: "services.styleProvider")
    var keyboardStyleProvider: KeyboardStyleProvider {
        get { styleProvider }
        set { styleProvider = newValue }
    }
    
    @available(*, deprecated, renamed: "services.autocompleteProvider")
    var autocompleteProvider: AutocompleteProvider {
        get { services.autocompleteProvider }
        set { services.autocompleteProvider = newValue }
    }
    
    @available(*, deprecated, renamed: "services.calloutActionProvider")
    var calloutActionProvider: CalloutActionProvider {
        get { services.calloutActionProvider }
        set { services.calloutActionProvider = newValue }
    }
    
    @available(*, deprecated, renamed: "services.dictationService")
    var dictationService: KeyboardDictationService {
        get { services.dictationService }
        set { services.dictationService = newValue }
    }
    
    @available(*, deprecated, renamed: "services.keyboardBehavior")
    var keyboardBehavior: KeyboardBehavior {
        get { services.keyboardBehavior }
        set { services.keyboardBehavior = newValue }
    }
    
    @available(*, deprecated, renamed: "services.layoutProvider")
    var layoutProvider: KeyboardLayoutProvider {
        get { services.layoutProvider }
        set { services.layoutProvider = newValue }
    }
    
    @available(*, deprecated, renamed: "services.spaceDragGestureHandler")
    var spaceDragGestureHandler: DragGestureHandler {
        get { services.spaceDragGestureHandler }
        set {
            let current = services.spaceDragGestureHandler
            let new = newValue as? Gestures.SpaceDragGestureHandler
            services.spaceDragGestureHandler = new ?? current
        }
    }
    
    @available(*, deprecated, renamed: "services.styleProvider")
    var styleProvider: KeyboardStyleProvider {
        get { services.styleProvider }
        set { services.styleProvider = newValue }
    }
}
#endif
