//
//  TypesHelper.swift
//  bankroll
//
//  Created by Etienne Goulet-Lang on 6/26/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

class TypesHelper {
    class func concat(list: [String], split: String = " ") -> String {
        return list.joinWithSeparator(split)
    }
    
    class func toJsonString(obj: AnyObject) -> String? {
        var err: NSError?
        var nsdata: NSData?
        do {
            nsdata = try NSJSONSerialization.dataWithJSONObject(obj, options: NSJSONWritingOptions())
        } catch let error as NSError {
            err = error
            nsdata = nil
        }
        
        if err != nil {
            return nil
        } else {
            return NSString(data: nsdata!, encoding: NSUTF8StringEncoding)! as String
        }
    }
    
    class func jsonStringToDict(str: String?) -> [String: AnyObject] {
        if  let s = str,
            let d = NSString(string: s).dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                if let r = try NSJSONSerialization.JSONObjectWithData(d, options: .AllowFragments) as? [String : AnyObject] {
                    return r
                }
            } catch {}
        }
        return [:]
    }
}