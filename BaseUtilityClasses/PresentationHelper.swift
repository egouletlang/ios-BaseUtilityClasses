//
//  PresentationHelper.swift
//  bankroll
//
//  Created by Etienne Goulet-Lang on 7/3/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public class PresentationHelper {
    
    // MARK: - Navigation -
    public class func buildNavBarSpace(width: CGFloat) -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        button.width = width
        return button
    }
    public class func buildNavBarButton(image: UIImage, target: AnyObject?, action: Selector, tintColor: UIColor? = nil) -> UIBarButtonItem {
        let button = UIButton(type: UIButtonType.Custom)
        button.setImage(image, forState: UIControlState.Normal)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(0, 0, 20, 20)
        
        let ret = UIBarButtonItem(customView: button)
        ret.width = 20
        return ret
    }
    public class func buildNavBarLabel(label: String, target: AnyObject?, action: Selector, tintColor: UIColor? = UIColor.whiteColor()) -> UIBarButtonItem {
        
        let button = UIButton(type: UIButtonType.Custom)
        button.setTitle(label, forState: .Normal)
        button.setTitleColor(tintColor, forState: .Normal)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        button.sizeToFit()
        
        let ret = UIBarButtonItem(customView: button)
        ret.width = button.frame.width
        return ret
    }
    
    
    // MARK: - Alert -
    public class func displayAlert<T>(
        viewController: UIViewController,
        labels: [String],
        vals: [String: T],
        styles: [String: UIAlertActionStyle] = ["Cancel": .Cancel],
        withTitle: String? = nil,
        withMessage: String? = nil,
        callback: (key: String, val: T)->Void) {
        self.displayAlert(viewController, labels: labels, styles:styles, withTitle: withTitle, withMessage: withMessage) { (index) in
            if let key = labels.get(index),
                let val = vals[key] {
                callback(key: key, val: val)
            }
        }
    }
    
    public class func displayAlert(
        viewController: UIViewController,
        labels: [String],
        styles: [String: UIAlertActionStyle] = [:],
        withTitle: String? = nil,
        withMessage: String? = nil,
        callback: (index: Int)->Void) {
        let alert = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .Alert)
        
        let dismiss = {
            ThreadHelper.checkedExecuteOnMainThread() {
                alert.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        for i in 0 ..< labels.count {
            alert.addAction(UIAlertAction(title: labels[i], style: styles[labels[i]] ?? .Default) { (action: UIAlertAction) -> Void in
                if let index = alert.actions.indexOf(action) {
                    callback(index: index)
                }
                dismiss()
                })
        }
        
        ThreadHelper.checkedExecuteOnMainThread() {
            viewController.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Handle Share Options -
    public class func displayActionSheet<T>(
        viewController: UIViewController,
        labels: [String],
        vals: [T],
        withTitle: String? = nil,
        withMessage: String? = nil,
        withCancel: Bool=true,
        withCancelCallback: (()->Void)?=nil,
        callback: (key: String, val: T)->Void) {
        displayActionSheet(viewController, labels: labels, withTitle: withTitle, withMessage: withMessage, withCancel: withCancel) { (index) in
            if let key = labels.get(index),
                let val = vals.get(index) {
                callback(key: key, val: val)
            } else if index == -1 {
                withCancelCallback?()
            }
        }
    }
    
    public class func displayActionSheet(
        viewController: UIViewController,
        labels: [String],
        withTitle: String? = nil,
        withMessage: String? = nil,
        withCancel: Bool=true,
        callback: (index: Int)->Void) {
        let actionSheet: UIAlertController! // = UIAlertController(title: withTitle, message: withMessage, preferredStyle: UIAlertControllerStyle.ActionSheet)
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad {
            actionSheet = UIAlertController(title: withTitle, message: withMessage, preferredStyle: UIAlertControllerStyle.Alert)
        } else {
            actionSheet = UIAlertController(title: withTitle, message: withMessage, preferredStyle: UIAlertControllerStyle.ActionSheet)
        }
        let dismiss = {
            ThreadHelper.checkedExecuteOnMainThread() {
                actionSheet.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        for i in 0 ..< labels.count {
            actionSheet.addAction(UIAlertAction(title: labels[i], style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                if let index = actionSheet.actions.indexOf(action) {
                    callback(index: index)
                }
                dismiss()
                })
        }
        if withCancel {
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)  { (_) -> Void in
                callback(index: -1)
                dismiss()
                })
        }
        
        ThreadHelper.checkedExecuteOnMainThread() {
            viewController.presentViewController(actionSheet, animated: true, completion: nil)
        }
    }
}