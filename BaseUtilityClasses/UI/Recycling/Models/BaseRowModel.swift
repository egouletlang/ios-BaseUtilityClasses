//
//  BaseRowModel.swift
//  BaseUtilityClasses
//
//  Created by Etienne Goulet-Lang on 11/19/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//


import Foundation
import CoreGraphics
import UIKit

class BaseRowModel: NSObject {
    
    func getId() -> String {
        return "BASE"
    }
    func getContainerHeight() -> CGFloat {
        return self.height + self.padding.top + self.padding.bottom
    }
    
    // MARK: - Borders -
    struct BorderPadding {
        var left = Rect<CGFloat>(0, 0, 0, 0)
        var top = Rect<CGFloat>(0, 0, 0, 0)
        var right = Rect<CGFloat>(0, 0, 0, 0)
        var bottom = Rect<CGFloat>(0, 0, 0, 0)
    }
    var borders = Rect<Bool>(false, false, false, false) // L, T, R, B
    var borderColor: UIColor?
    var borderPadding = BorderPadding()
    
    func withBorders(l: Bool = false, t: Bool = false, r: Bool = false, b: Bool = false) -> BaseRowModel {
        self.setLeftBorderTo(show: l, padding: nil)
        self.setTopBorderTo(show: t, padding: nil)
        self.setRightBorderTo(show: r, padding: nil)
        self.setBottomBorderTo(show: b, padding: nil)
        return self
    }
    func withLeftBorder(show: Bool = true, padding: Rect<CGFloat>? = nil) -> BaseRowModel {
        self.setLeftBorderTo(show: show, padding: padding)
        return self
    }
    func withTopBorder(show: Bool = true, padding: Rect<CGFloat>? = nil) -> BaseRowModel {
        self.setTopBorderTo(show: show, padding: padding)
        return self
    }
    func withRightBorder(show: Bool = true, padding: Rect<CGFloat>? = nil) -> BaseRowModel {
        self.setRightBorderTo(show: show, padding: padding)
        return self
    }
    func withBottomBorder(show: Bool = true, padding: Rect<CGFloat>? = nil) -> BaseRowModel {
        self.setBottomBorderTo(show: show, padding: padding)
        return self
    }
    func setLeftBorderTo(show: Bool, padding: Rect<CGFloat>?) {
        self.borders.left = show
        if let p = padding {
            self.borderPadding.left = p
        }
    }
    func setTopBorderTo(show: Bool, padding: Rect<CGFloat>?){
        self.borders.top = show
        if let p = padding {
            self.borderPadding.top = p
        }
    }
    func setRightBorderTo(show: Bool, padding: Rect<CGFloat>?) {
        self.borders.right = show
        if let p = padding {
            self.borderPadding.right = p
        }
    }
    func setBottomBorderTo(show: Bool, padding: Rect<CGFloat>?) {
        self.borders.bottom = show
        if let p = padding {
            self.borderPadding.bottom = p
        }
    }
    
    func withDefaultBottomBorder() -> BaseRowModel {
        self.setBottomBorderTo(show: true, padding: nil)
        return self
    }
    
    func withBorderColor(color: UIColor? = nil) -> BaseRowModel {
        self.setBorderColorTo(color: color)
        return self
    }
    func setBorderColorTo(color: UIColor? = nil) {
        self.borderColor = color
    }
    
    // MARK: - Padding -
    var padding = Rect<CGFloat>(10, 0, 10, 0)
    func withPadding(l: CGFloat? = nil, t: CGFloat? = nil, r: CGFloat? = nil, b: CGFloat? = nil) -> BaseRowModel {
        self.setLeftPaddingTo(l: l)
        self.setTopPaddingTo(t: t)
        self.setRightPaddingTo(r: r)
        self.setBottomPaddingTo(b: b)
        return self
    }
    func withLeftPadding(l: CGFloat?) -> BaseRowModel {
        self.setLeftPaddingTo(l: l)
        return self
    }
    func withTopPadding(t: CGFloat?) -> BaseRowModel {
        self.setTopPaddingTo(t: t)
        return self
    }
    func withRightPadding(r: CGFloat?) -> BaseRowModel {
        self.setRightPaddingTo(r: r)
        return self
    }
    func withBottomPadding(b: CGFloat?) -> BaseRowModel {
        self.setBottomPaddingTo(b: b)
        return self
    }
    func setLeftPaddingTo(l: CGFloat?) {
        if let left = l {
            self.padding.left = left
        }
    }
    func setTopPaddingTo(t: CGFloat?) {
        if let top = t {
            self.padding.top = top
        }
    }
    func setRightPaddingTo(r: CGFloat?) {
        if let right = r {
            self.padding.right = right
        }
    }
    func setBottomPaddingTo(b: CGFloat?) {
        if let bottom = b {
            self.padding.bottom = bottom
        }
    }
    
    // MARK: - Background Color -
    var backgroundColor: UIColor?
    func withBackgroundColor(color: UIColor? = nil) -> BaseRowModel {
        self.setBackgroundColorTo(color: color)
        return self
    }
    func setBackgroundColorTo(color: UIColor?) {
        self.backgroundColor = color
    }
    
    // MARK: - Height -
    var height: CGFloat = 0
    func withHeight(height: CGFloat) -> BaseRowModel {
        self.setHeightTo(height: height)
        return self
    }
    func setHeightTo(height: CGFloat) {
        self.height = height
    }
    
    // MARK: - Tag -
    var tag: String?
    func withTag(tag: String) -> BaseRowModel {
        self.setTagTo(tag: tag)
        return self
    }
    func setTagTo(tag: String?) {
        self.tag = tag
    }
    
    // MARK: - Searchability -
    static var ANY_QUERY = ".*"
    static var NO_QUERY = "^.*"
    var searchable = BaseRowModel.NO_QUERY
    func alwaysVisible() -> BaseRowModel {
        self.setSearchableTo(searchable: BaseRowModel.ANY_QUERY)
        return self
    }
    func neverVisible() -> BaseRowModel {
        self.setSearchableTo(searchable: BaseRowModel.NO_QUERY)
        return self
    }
    func withSearchable(searchable: String) -> BaseRowModel {
        self.setSearchableTo(searchable: searchable)
        return self
    }
    func setSearchableTo(searchable: String) {
        self.searchable = searchable
    }
    
    // MARK: - Interactability -
    var clickResponse: AnyObject?
    var longPressResponse: AnyObject?
    func withClickResponse(obj: AnyObject?) -> BaseRowModel {
        self.setClickResponseTo(obj: obj)
        return self
    }
    func setClickResponseTo(obj: AnyObject?) {
        self.clickResponse = obj
    }
    func withLongPressResponse(obj: AnyObject?) -> BaseRowModel {
        self.setLongPressResponseTo(obj: obj)
        return self
    }
    func setLongPressResponseTo(obj: AnyObject?) {
        self.longPressResponse = obj
    }
    
    // MARK: - Arg Collection -
    // canCollect means this model produces a cell meant to collect a user input
    func canCollectArgs() -> Bool {
        return argCollectionKey != nil
    }
    // canSubmit means that this model will allow the user to submit the current content.
    var canSubmitArgs = true
    var argCollectionKey: String?
    func withArgCollectionKey(key: String? = nil) -> BaseRowModel {
        self.setArgCollectionKeyTo(key: key)
        return self
    }
    func setArgCollectionKeyTo(key: String?) {
        self.argCollectionKey = key
    }
    
    var originalCollectionObj: AnyObject?
    var argCollectionObj: AnyObject?
    func withArgCollectionObj(obj: AnyObject? = nil) -> BaseRowModel {
        self.setArgCollectionKObjTo(obj: obj)
        return self
    }
    func setArgCollectionKObjTo(obj: AnyObject?) {
        self.originalCollectionObj = obj
        self.argCollectionObj = obj
    }
    
    // MARK: - CleanUp -
    func cleanUp() {}
}

