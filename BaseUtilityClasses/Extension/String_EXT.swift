//
//  String_EXT.swift
//  bankroll
//
//  Created by Etienne Goulet-Lang on 6/29/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

extension String {
    
    func contains(text: String) -> Bool {
        return self.rangeOfString(text) != nil
    }
    
    func startsWith(text: String) -> Bool {
        return CFStringHasPrefix(self, text)
    }
    
    func endsWith(text: String) -> Bool {
        return CFStringHasSuffix(self, text)
    }
}