//
//  Types.swift
//  BaseUtilityClasses
//
//  Created by Etienne Goulet-Lang on 11/19/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

open class Rect<T: Equatable>: Sequence {
    
    init(_ l: T, _ t: T,_ r: T,_ b: T) {
        self.left = l
        self.top = t
        self.right = r
        self.bottom = b
    }
    
    var left: T
    var top: T
    var right: T
    var bottom: T
    
    func equals(_ rhs: Rect<T>) -> Bool {
        return (self.left == rhs.left) ||
            (self.top == rhs.top) ||
            (self.right == rhs.right) ||
            (self.bottom == rhs.bottom)
    }
    
    open func makeIterator() -> IndexingIterator<[T]> {
        var arr = [T]()
        arr.append(left)
        arr.append(top)
        arr.append(right)
        arr.append(bottom)
        return arr.makeIterator()
    }
}
