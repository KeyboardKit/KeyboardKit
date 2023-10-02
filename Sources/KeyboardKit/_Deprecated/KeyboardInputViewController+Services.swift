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
    var keyboardActionHandler: KeyboardActionHandler { services.actionHandler }
    
    @available(*, deprecated, renamed: "services.layoutProvider")
    var keyboardLayoutProvider: KeyboardLayoutProvider { layoutProvider }
    
    @available(*, deprecated, renamed: "services.styleProvider")
    var keyboardStyleProvider: KeyboardStyleProvider { styleProvider }
    
    @available(*, deprecated, renamed: "services.autocompleteProvider")
    var autocompleteProvider: AutocompleteProvider { services.autocompleteProvider }
    
    @available(*, deprecated, renamed: "services.calloutActionProvider")
    var calloutActionProvider: CalloutActionProvider { services.calloutActionProvider }
    
    @available(*, deprecated, renamed: "services.dictationService")
    var dictationService: KeyboardDictationService { services.dictationService }
    
    @available(*, deprecated, renamed: "services.keyboardBehavior")
    var keyboardBehavior: KeyboardBehavior { services.keyboardBehavior }
    
    @available(*, deprecated, renamed: "services.layoutProvider")
    var layoutProvider: KeyboardLayoutProvider { services.layoutProvider }
    
    @available(*, deprecated, renamed: "services.spaceDragGestureHandler")
    var spaceDragGestureHandler: DragGestureHandler { services.spaceDragGestureHandler }
    
    @available(*, deprecated, renamed: "services.styleProvider")
    var styleProvider: KeyboardStyleProvider { services.styleProvider }
}
#endif
