//
//  TypesHelper.swift
//  bankroll
//
//  Created by Etienne Goulet-Lang on 6/26/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

open class TypesHelper {
    open class func concat(_ list: [String], split: String = " ") -> String {
        return list.joined(separator: split)
    }
    
    open class func toJsonString(_ obj: AnyObject) -> String? {
        var err: NSError?
        var nsdata: Data?
        do {
            nsdata = try JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions())
        } catch let error as NSError {
            err = error
            nsdata = nil
        }
        
        if err != nil {
            return nil
        } else {
            return NSString(data: nsdata!, encoding: String.Encoding.utf8.rawValue)! as String
        }
    }
    
    open class func jsonStringToDict(_ str: String?) -> [String: AnyObject] {
        
        if  let s = str,
            let d = NSString(string: s).data(using: String.Encoding.utf8.rawValue) {
            do {
                if let r = try JSONSerialization.jsonObject(with: d, options: .allowFragments) as? [String : AnyObject] {
                    return r
                }
            } catch {}
        }
        return [:]
    }
}
