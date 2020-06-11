//
//  LXDrownMenuView.swift
//  LXDrownMenuManager
//
//  Created by Mac on 2020/5/10.
//

import UIKit

private protocol LXDrownMenuViewDelegate {}
open class LXDrownMenuView: UIView, LXDrownMenuViewDelegate {
     
    ///动画时常
    open var animateDuration: TimeInterval = 0.25
    
    /// view的透明度
    open var viewAlpha: CGFloat = 0.7

    /// presented跟控制器
    open var aboveViewController: UIViewController? {
        var aboveController = UIApplication.shared.delegate?.window??.rootViewController
        while aboveController?.presentedViewController != nil {
            aboveController = aboveController?.presentedViewController
        }
        return aboveController
    }
    
    open lazy var containerView: UIImageView = {
        let containerV = UIImageView()
        containerV.isUserInteractionEnabled = true
        containerV.backgroundColor = UIColor.white
        return containerV
    }()
    
    ///背景图片
    open var bgImage: UIImage? {
        didSet{
            guard let bgImg = self.bgImage else {return}
            self.containerView.image = bgImg
        }
    }
    
    ///内容控制器vc
    open var contentController: UIViewController?
    
    ///内容view
    open var content: UIView?
    
     ///销毁
    open func dismiss() {}
    
    public override init(frame: CGRect) {
         super.init(frame: frame)
         addSubview(containerView)
         backgroundColor = UIColor.black.withAlphaComponent(viewAlpha)
     }
     
    required public init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {return}
        let view = self.hitTest(point, with: event)
        if view is LXDrownMenuViewDelegate {
            dismiss()
        }
    }
}

