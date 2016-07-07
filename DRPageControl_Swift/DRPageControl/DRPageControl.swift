//
//  DRPageControl.swift
//  DRPageControl_Swift
//
//  Created by xqzh on 16/7/6.
//  Copyright © 2016年 xqzh. All rights reserved.
//

import UIKit
import CoreGraphics

let kDefaultNumberOfPages          = 0
let kDefaultCurrentPage            = -1
let kDefaultHideForSinglePage      = true
let kDefaultShouldResizeFromCenter = true
let kDefaultSpacingBetweenDots     = 8
let kDefaultDotSize                = 8
let kDefaultDotColor               = UIColor.whiteColor()

class DRPageControl: UIControl {

    var dotImage:UIImage?
    var currentDotImage:UIImage?
    var dotSize:Int?
    var dotColor:UIColor? {
        didSet {
            // 设置dot 颜色
            setDotsColor()
        }
    }
    var spacingBetweenDots:Int?
    var numberOfPages:Int? {
        didSet {
            // 设置dot views
            setUpDots()
        }
    }
    var currentPage:Int {
        didSet {
            // 设置选中状态
            setSeclectedDot()
        }
    }
    var hidesForSinglePage:Bool
    var shouldResizeFromCenter:Bool?
    var dots:NSMutableArray
    
    var width:CGFloat
    var height:CGFloat
    
    override init(frame: CGRect) {

        width  = frame.width
        height = frame.height
        
        spacingBetweenDots     = kDefaultSpacingBetweenDots
        currentPage            = kDefaultCurrentPage
        hidesForSinglePage     = kDefaultHideForSinglePage
        shouldResizeFromCenter = kDefaultShouldResizeFromCenter
        dotSize                = kDefaultDotSize
        dotColor               = kDefaultDotColor
        dots                   = NSMutableArray()
        super.init(frame: frame)
        
        numberOfPages = kDefaultNumberOfPages
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置dots view
    func setUpDots() {
        
        let realWidth = (numberOfPages! - 1) * spacingBetweenDots! + numberOfPages! * self.dotSize!
        let startX    = (width - CGFloat(realWidth)) / 2
        let startY    = (height - CGFloat(self.dotSize!)) / 2
        
        for  i in 0..<numberOfPages! {
            
            let x = startX + CGFloat(i * (spacingBetweenDots! + dotSize!))
            let view = UIView(frame: CGRectMake(x, startY, CGFloat(dotSize!), CGFloat(dotSize!)))
            view.backgroundColor = UIColor.clearColor()
            view.layer.cornerRadius = CGFloat(dotSize!) / 2
            view.layer.borderColor = dotColor!.CGColor
            view.layer.borderWidth = 1
            self.addSubview(view)
            dots.addObject(view)
        }
        
        // 默认选中第一个
        currentPage = 0
    }
    
    
    // 设置dot 颜色
    func setDotsColor() {
        for dot in dots {
            let view:UIView = dot as! UIView
            view.layer.borderColor = dotColor!.CGColor
        }
        
        // 更新
        setSeclectedDot()
    }
    
    // 设置选中状态
    func setSeclectedDot() {
        let scale:CGFloat = 1.4
        
        // 当前dot 改变状态
        let view = dots[currentPage] as? UIView
        
        UIView.animateWithDuration(0.75,
                                   delay: 0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: -20,
                                   options: UIViewAnimationOptions.CurveLinear ,
                                   animations:
            {
                view?.backgroundColor = self.dotColor!
                view?.transform = CGAffineTransformMakeScale(scale, scale)
            },
                                   completion: nil)
        

        // 其他dot 复原
        for index in 0..<numberOfPages! {
            print("=====\(index)")
            if index != currentPage {
                let lastView = dots[index] as? UIView
                
                
                UIView.animateWithDuration(0.75,
                                           delay: 0,
                                           usingSpringWithDamping: 0.5,
                                           initialSpringVelocity: 0,
                                           options: UIViewAnimationOptions.CurveLinear,
                                           animations:
                    {
                        lastView?.backgroundColor = UIColor.clearColor()
                        lastView?.transform = CGAffineTransformIdentity
                    },
                                           completion: nil)
            }
        }
        
        
    }
    

        
}
