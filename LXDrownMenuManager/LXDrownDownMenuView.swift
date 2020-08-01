//
//  LXDrownDownMenuView.swift
//  LXDrownMenuModule
//
//  Created by XL on 2020/5/9.
//  Copyright © 2020 XL. All rights reserved.
//

import UIKit
import LXFitManager

public class LXDrownDownMenuView: LXDrownMenuView {
    
   ///比屏幕尺寸小多少
   public var letMargin: CGFloat = 10
    
   /// 距顶部间距
   public var topMargin: CGFloat = 10
   
    /// 内容内间距
   public var contentSpacingX: CGFloat = 10
   public var contentSpacingY: CGFloat = 10

    ///内容控制器vc
   public override var contentController: UIViewController? {
        didSet{
            self.content = self.contentController?.view
        }
    }
    
    ///内容view
   public override var content: UIView? {
        didSet{
            guard let content = self.content else {return}
            
            containerView.layer.cornerRadius = LXFit.fitFloat(6)
            containerView.clipsToBounds = true
            
            let contenPoint = CGPoint(x: LXFit.fitFloat(contentSpacingX), y: LXFit.fitFloat(contentSpacingY))
            let contenSize =  CGSize(width: content.frame.width - LXFit.fitFloat(contentSpacingX) * 2, height: content.frame.height - LXFit.fitFloat(contentSpacingY) * 2)
            content.frame = CGRect(origin: contenPoint, size: contenSize)
            
            self.containerView.frame.size.height = content.frame.height + LXFit.fitFloat(contentSpacingY) * 2
            self.containerView.frame.size.width = content.frame.width + LXFit.fitFloat(contentSpacingX) * 2
            self.containerView.addSubview(content)
        }
    }

     ///销毁
    public override func dismiss() {
         UIView.animate(withDuration: animateDuration, animations: {
             self.containerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
             self.backgroundColor = UIColor.black.withAlphaComponent(0.01)
         }) {(finished) -> () in
             self.removeFromSuperview()
         }
     }
}


extension LXDrownDownMenuView {
    
    ///显示 view 被点击的view
    public func showFrom(from view: UIView) {
        
        guard let rootView = aboveViewController?.view else {
            return
        }
        rootView.addSubview(self)
        self.frame = rootView.bounds
        let rect  = view.convert(view.bounds, to: rootView)
        self.containerView.layer.anchorPoint = CGPoint(x: (rect.midX - LXFit.fitFloat(letMargin)) / self.containerView.frame.width , y: 0)
        
        let containerPoint = CGPoint(x: LXFit.fitFloat(letMargin), y: rect.maxY + LXFit.fitFloat(topMargin))
        self.containerView.frame.origin = containerPoint
        self.containerView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        UIView.animate(withDuration: animateDuration) {
            self.containerView.transform = CGAffineTransform.identity
            self.backgroundColor = UIColor.black.withAlphaComponent(self.viewAlpha)

        }
    }
}

