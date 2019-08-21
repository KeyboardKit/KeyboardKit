//
//  KeyboardToolbarComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 A keyboard toolbar component is a view that can be added to
 a keyboard toolbar's horizontal stack view. For stack views
 with a different distribution than `.fillEqually`, you must
 set a specific width for each component.
 
 */

import UIKit

public protocol KeyboardToolbarComponent: HorizontalKeyboardComponent {}
