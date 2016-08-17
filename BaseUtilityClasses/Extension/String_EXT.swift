//
//  String_EXT.swift
//  bankroll
//
//  Created by Etienne Goulet-Lang on 6/29/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

public extension String {
    
    public func contains(text: String) -> Bool {
        return self.rangeOfString(text) != nil
    }
    
    public func startsWith(text: String) -> Bool {
        return CFStringHasPrefix(self, text)
    }
    
    public func endsWith(text: String) -> Bool {
        return CFStringHasSuffix(self, text)
    }
}