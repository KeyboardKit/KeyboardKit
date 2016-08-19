//
//  UITableViewControllerHeaderSize.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-02-02.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UITableViewController {

    public func autosizeTableViewHeaderToCellCount(cellCount: Int, cellHeight: Int) {
        let view = tableView.tableHeaderView!
        let totalHeight = UIScreen.mainScreen().bounds.height
        let totalCellHeight = CGFloat(cellCount * cellHeight)
        view.frame.size.height = totalHeight - CGFloat(totalCellHeight)
        self.tableView.tableHeaderView = view
    }
}
