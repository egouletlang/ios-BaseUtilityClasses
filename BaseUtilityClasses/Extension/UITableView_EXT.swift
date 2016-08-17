//
//  UITableView_EXT.swift
//  Bankroll
//
//  Created by Etienne Goulet-Lang on 5/31/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    /// Returns whether NSIndexPath is out of bounds in the current table view
    /// Can be used as safe guard before update/delete operations in the table view to avoid crashes
    public func isIndexPathValid(index: NSIndexPath) -> Bool {
        return (index.section <= self.numberOfSections) && (index.row <= self.numberOfRowsInSection(index.section))
    }
    
}