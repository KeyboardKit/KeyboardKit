//
//  EnabledListItem.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-10-14.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This list item view is used to show if a certain feature is
 enabled or not.
 */
struct EnabledListItem: View {
    
    let isEnabled: Bool
    let enabledText: String
    let disabledText: String
    
    var body: some View {
        Label {
            Text(isEnabled ? enabledText : disabledText)
        } icon: {
            isEnabled ? Image.checkmark : Image.alert
        }.foregroundColor(isEnabled ? .green : .orange)
    }
}

struct EnabledListItem_Previews: PreviewProvider {
    
    static var previews: some View {
        EnabledListItem(isEnabled: true, enabledText: "Enabled", disabledText: "Disabled")
        EnabledListItem(isEnabled: false, enabledText: "Enabled", disabledText: "Disabled")
    }
}
