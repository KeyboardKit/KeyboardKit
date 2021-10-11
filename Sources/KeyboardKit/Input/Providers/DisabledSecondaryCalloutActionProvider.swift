//
//  DisabledSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This disabled provider can be used to disable the secondary
 actions from showing up in system keyboards.
 */
class DisabledSecondaryCalloutActionProvider: SecondaryCalloutActionProvider {
    
    func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] { [] }
}
