//
//  KeyboardButtonRowView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardButtonRowView: UIView {
    
    public init(rowHeight: CGFloat) {
        self.rowHeight = rowHeight
        super.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        rowHeight = frame.height
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        rowHeight = 50
        super.init(coder: aDecoder)
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: rowHeight)
    }
    
    var rowHeight: CGFloat {
        didSet { invalidateIntrinsicContentSize() }
    }
}
