//
//  BaseRowView.swift
//  BaseUtilityClasses
//
//  Created by Etienne Goulet-Lang on 11/19/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

private let DEFAULT_ACTIVE_BKG_COLOR = UIColor(rgb: 0xEEEEEE)
private let DEFAULT_INACTIVE_BKG_COLOR = UIColor(rgb: 0xFFFFFF)
private let DEFAULT_BORDER_COLOR = UIColor(rgb: 0x7B868C)

class BaseRowView: BaseUIView {
    
    let borders: [CALayer] = {
        var ret = [CALayer]()
        
        for i in 0 ..< 4 {
            ret.append(CALayer())
            ret[i].backgroundColor = DEFAULT_BORDER_COLOR.cgColor
        }
        
        return ret
    }()
    var contentView = BaseUIView(frame: CGRect.zero)
    
    // MARK: - Lifecycle -
    override func createAndAddSubviews() {
        super.createAndAddSubviews()
        self.addSubview(contentView)
        contentView.clipsToBounds = true
        contentView.passThroughDefault = true
        
        for layer in borders {
            self.layer.addSublayer(layer)
        }
    }
    override func addGestureRecognition() {
        super.addGestureRecognition()
        if handleGesturesAutomatically() {
            self.addTap(self, selector: #selector(BaseRowView.containerTapped))
            self.addLongPress(self, selector: "containerLongPressed")
        }
    }
    override func frameUpdate() {
        super.frameUpdate()
        
        if let leftPadding = model?.borderPadding.left {
            self.borders[0].frame.size = CGSize(
                width: LayoutHelper.onePixel,
                height: self.frame.height - leftPadding.top - leftPadding.bottom)
            self.borders[0].frame.origin = CGPoint(x: leftPadding.left, y: leftPadding.top)
        }
        if let topPadding = model?.borderPadding.top {
            self.borders[1].frame.size = CGSize(
                width: self.frame.width - topPadding.left - topPadding.right,
                height: LayoutHelper.onePixel)
            self.borders[1].frame.origin = CGPoint(x: topPadding.left, y: topPadding.top)
        }
        if let rightPadding = model?.borderPadding.right {
            self.borders[2].frame.size = CGSize(
                width: LayoutHelper.onePixel,
                height: self.frame.height - rightPadding.top - rightPadding.bottom)
            self.borders[2].frame.origin = CGPoint(x: self.frame.width - rightPadding.right - LayoutHelper.onePixel, y: rightPadding.top)
        }
        if let bottomPadding = model?.borderPadding.bottom {
            self.borders[3].frame.size = CGSize(
                width: self.frame.width - bottomPadding.left - bottomPadding.right,
                height: LayoutHelper.onePixel)
            self.borders[3].frame.origin = CGPoint(x: bottomPadding.left, y: self.frame.height - bottomPadding.bottom - LayoutHelper.onePixel)
        }
        
        self.contentView.frame.size = self.getAvailableSize()
        self.contentView.frame.origin = self.getOffset()
        
    }
    private func getAvailableSize() -> CGSize {
        if let m = model {
            return self.frame.insetBy(
                dx: (m.padding.left + m.padding.right) / 2,
                dy: (m.padding.top + m.padding.bottom) / 2).size
        }
        return self.frame.size
    }
    private func getOffset() -> CGPoint {
        if let m = model {
            return CGPoint(x: m.padding.left, y: m.padding.top)
        }
        return CGPoint.zero
    }
    
    // MARK: - Model -
    weak var model: BaseRowModel?
    func setData(model: BaseRowModel) {
        self.model = model
        
        self.backgroundColor = model.backgroundColor ?? DEFAULT_INACTIVE_BKG_COLOR
        
        for layer in borders {
            layer.backgroundColor = model.borderColor?.cgColor ?? DEFAULT_BORDER_COLOR.cgColor
        }
        
        borders[0].isHidden = !model.borders.left
        borders[1].isHidden = !model.borders.top
        borders[2].isHidden = !model.borders.right
        borders[3].isHidden = !model.borders.bottom
    }
    
    // MARK: - Delegate -
    weak var baseRowViewDelegate: BaseRowViewDelegate?
    func handleGesturesAutomatically() -> Bool {
        return true
    }
    
    func containerTapped() {
        self.baseRowViewDelegate?.active(view: self)
        if let m = self.model, m.clickResponse != nil {
            self.baseRowViewDelegate?.tapped(model: m, view: self)
        }
    }
    func containerLongPressed() {
        self.baseRowViewDelegate?.active(view: self)
        if let m = self.model, m.longPressResponse != nil {
            self.baseRowViewDelegate?.longPressed(model: m, view: self)
        }
    }
    
    // MARK: - Touch -
    func tapped(location: CGPoint) -> Bool {
        return false
    }
    func longPressed(location: CGPoint) -> Bool {
        return false
    }
    
    // MARK: - Recycling -
    func prepareForReuse() {
        
    }
}
