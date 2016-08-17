//
//  Array_EXT.swift
//  bankroll
//
//  Created by Etienne Goulet-Lang on 7/3/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

extension Array {
    
    func foreach(block: (Element)->()) {
        for item in self {
            block(item)
        }
    }
    
    /// Returns the element or nil if the index was out of bounds
    /// NOTICE, if T is a nill-able element (like String?) that the return will be double nillable. Not sure how to deal with that
    func get(index: Int) -> Element? {
        if self.count > index && index >= 0 {
            return self[index]
        } else {
            return nil
        }
    }
}