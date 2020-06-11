//
//  LXDrownUpMenuView.swift
//  LXDrownMenuModule
//
//  Created by XL on 2020/5/9.
//  Copyright © 2020 XL. All rights reserved.
//

import UIKit

public class LXDrownUpMenuView: LXDrownMenuView {
      
    private var maxH: CGFloat = 0.0

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
            
            content.frame.origin = CGPoint.zero
            self.containerView.frame.size.height = content.frame.maxY
            self.maxH = content.frame.maxY
            self.containerView.frame.size.width = content.frame.maxX
            self.containerView.addSubview(content)
        }
    }
    
    ///销毁
   public override func dismiss() {
       UIView.animate(withDuration: animateDuration, animations: {
           self.containerView.frame.origin.y = UIScreen.main.bounds.height
           self.alpha = 0.0
       }) {(finished) -> () in
           self.removeFromSuperview()
       }
   }
}

extension LXDrownUpMenuView {
    
    //显示
    public func show() {
        guard let rootView = aboveViewController?.view else {
            return
        }
        rootView.addSubview(self)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + self.maxH)
        self.containerView.frame.origin.y = UIScreen.main.bounds.height
        self.alpha = 0.0
        UIView.animate(withDuration:animateDuration) {
            self.alpha = self.viewAlpha
            self.containerView.frame.origin.y = UIScreen.main.bounds.height - self.maxH
        }
    }   
}


