//
//  File.swift
//  XCUserGuide
//
//  Created by Simon on 2017/3/20.
//  Copyright © 2017年 Simon. All rights reserved.
//

import Foundation
import UIKit
import AMPopTip

public enum XCUserGuideSharp {
    case Circle
    case Rectangle
}

open class XCUserGuideSharpItem:NSObject {
    
    open var frame:CGRect = CGRect(x: 0, y: 0, width: 30, height: 30)
    open weak var guideView:UIView?
    open var title:String?
    open var sharp:XCUserGuideSharp = XCUserGuideSharp.Circle
    open var direction:AMPopTipDirection = .down
}

open class XCUserGuideView:UIView {
    
    open private(set) var isShow:Bool = false
    open private(set) var backMaskView:UIView?
    open var hideCompletion:(() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initGuideUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initGuideUI()
    }
    
    private func initGuideUI(){
        
        self.isShow = false
        self.alpha = 0
        self.backgroundColor = UIColor.clear
        self.backMaskView = UIView(frame: self.bounds)
        self.backMaskView?.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        self.backMaskView?.autoresizingMask = [.flexibleLeftMargin ,
            UIViewAutoresizing.flexibleWidth        ,
            UIViewAutoresizing.flexibleRightMargin  ,
            UIViewAutoresizing.flexibleTopMargin    ,
            UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleBottomMargin]
        self.backMaskView?.isUserInteractionEnabled = false
        self.insertSubview(self.backMaskView!, at: 0)
        let tapRec:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(XCUserGuideView.offBox(tap:)) )
        tapRec.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapRec)
        
    }
    
    @objc fileprivate func offBox(tap : UITapGestureRecognizer){
        
        self.show(rootView: nil, show: false, completion: nil)
    }
    
    open func hidden( completion:(( Bool) -> Void)?){
        self.show(rootView: nil, show: false, completion: completion)
    }
    
    private func show(rootView:UIView?, show:Bool, completion:(( Bool) -> Void)?){
        self.hideAllTip()
        
        if show == self.isShow{
            if let _ = completion{
                completion!(true)
            }
            return
        }
        self.isShow = show
        var alpha:CGFloat = 0
        if isShow{
            if self.superview == nil{
                if let _ = rootView{
                    self.frame = rootView!.bounds
                    rootView?.addSubview(self)
                }else{
                    let view:UIView = ((UIApplication.shared.delegate?.window)!)!
                    self.frame = view.bounds
                    view.addSubview(self)
                }
            }
            
            self.alpha = 0
            alpha = 1
        }
    
        UIView.animate(withDuration: 0.5, animations: { [weak self] () in
            self?.alpha = alpha
        }, completion: { [weak self] (finished) in
            if let _ = completion{
                completion!(finished)
            }
            if self?.hideCompletion != nil{
                self?.hideCompletion!()
            }
            if self?.isShow == false{
                self?.removeFromSuperview()
            }
        })
    }
    
    open func showTip(title:String, direction:AMPopTipDirection, frame:CGRect){
        let popTip:AMPopTip = AMPopTip()
        popTip.shouldDismissOnTap = false
        popTip.shouldDismissOnTapOutside = false
        popTip.shouldDismissOnSwipeOutside = false
        popTip.offset = 4
        popTip.edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        popTip.popoverColor = UIColor.clear
        popTip.textAlignment = .center
        let color:UIColor = UIColor.white
        popTip.borderColor = color
        popTip.textColor = color;
        popTip.borderWidth = 1.0
        popTip.animationIn = 0.6
        popTip.animationOut = 0.4
        popTip.isUserInteractionEnabled = false
        popTip.showText(title, direction: direction, maxWidth: 300, in: self, fromFrame: frame)
//        self.popTipList.append(popTip)
    }
    
    open func show(rootView:UIView?, rectangles:Array<CGRect>?, circles:Array<CGRect>?, completion:((Bool) -> Void)? ){
        
        if rectangles?.count == 0 && circles?.count == 0{
            return
        }
        self.hideAllTip()
        
        let maskLayer:CAShapeLayer = CAShapeLayer();
        maskLayer.fillColor = UIColor.white.cgColor;
        var rootView1:UIView? = rootView;
        if rootView == nil{
            rootView1 = (UIApplication.shared.delegate?.window)!
        }
        
        let path:CGMutablePath = CGMutablePath()
        if let _ = rectangles{
            for rect1:CGRect in rectangles! {
                path.addRoundedRect(in: rect1, cornerWidth: 4, cornerHeight: 4)
            }
        }
        if let _ = circles{
            for rect1:CGRect in circles! {
                path.addEllipse(in: rect1)
            }
        }
        
        let rect:CGRect = (rootView1?.bounds)!
        path .addRect(rect)
        maskLayer.fillRule = kCAFillRuleEvenOdd
        maskLayer.fillMode = kCAFillModeBoth
        maskLayer.path = path
        self.backMaskView?.layer.mask = maskLayer
        self .show(rootView: rootView, show: true, completion: completion)
    }
    
    open func show(rootView:UIView?, item:XCUserGuideSharpItem, completion:(( Bool) -> Void)?){
        
        self.hideAllTip()
        var circles:Array<CGRect> = Array<CGRect>()
        var rectangles:Array<CGRect> = Array<CGRect>()
        var frame:CGRect = item.frame
        var rootView1:UIView? = rootView;
        if rootView == nil{
            rootView1 = (UIApplication.shared.delegate?.window)!
        }
        if let _ = item.guideView{
            frame = (item.guideView?.superview?.convert(frame, to: rootView1))!
        }
        switch item.sharp {
        case .Rectangle:
            rectangles.append(frame)
            break
        case .Circle:
            circles.append(frame)
            break
            
        }
        
        self.show(rootView: rootView1, rectangles: rectangles, circles: circles, completion:{[weak self] (finished) in
            
            if item.title != nil && (item.title?.characters.count)! > 0{
                self?.showTip(title: item.title!, direction: item.direction, frame: frame)
            }
            if let _ = completion{
                completion!( finished);
            }
        })
    }
    
    open func hideAllTip(){
        for view:UIView in self.subviews {
            if view.isKind(of: AMPopTip.self){
                let tip:AMPopTip = view as! AMPopTip
                tip.hide()
            }
        }
//        self.popTipList.removeAll()
    }
    
    open func show(rootView:UIView?, items:Array<XCUserGuideSharpItem>, completion:(( Bool) -> Void)?){
        
        self.hideAllTip()
        
        var circles:Array<CGRect> = Array<CGRect>()
        var rectangles:Array<CGRect> = Array<CGRect>()
        
        var rootView1:UIView? = rootView;
        if rootView == nil{
            rootView1 = (UIApplication.shared.delegate?.window)!
        }
        
        var frames:Array<CGRect> = Array<CGRect>()
        if items.count > 0{
            for item:XCUserGuideSharpItem in items {
                var frame:CGRect = item.frame
                if let _ = item.guideView{
                    frame = (item.guideView?.superview?.convert(frame, to: rootView1))!
                }
                frames.append(frame)
                switch item.sharp {
                case .Rectangle:
                    rectangles.append(frame)
                    break
                case .Circle:
                    circles.append(frame)
                    break
                }
            }
        }
        
        self.show(rootView: rootView1, rectangles: rectangles, circles: circles, completion:{[weak self] ( finished) in
            
            if items.count > 0{
                var index:Int = 0
                for item:XCUserGuideSharpItem in items {
                    if item.title != nil && (item.title?.characters.count)! > 0{
                        self?.showTip(title: item.title!, direction: item.direction, frame: frames[index])
                    }
                    index = index + 1
                }
            }
            
            if let _ = completion{
                completion!(finished);
            }
        })
    }
}








