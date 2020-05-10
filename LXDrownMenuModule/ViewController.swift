//
//  ViewController.swift
//  LXDrownMenuModule
//
//  Created by XL on 2020/5/9.
//  Copyright © 2020 XL. All rights reserved.
//

import UIKit
import LXFitManager
import LXDrownMenuManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.red
        btn.frame = CGRect(x: LXFit.fitFloat(250), y: 100, width: LXFit.fitFloat(100), height: 100)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: UIControl.Event.touchUpInside)
        
    }

    
    @objc func btnClick(_ btn: UIButton) {
        
       let menu = LXDrownDownMenuView()
        menu.bgImage = UIImage(named: "timg")
        menu.letMargin = (UIScreen.main.bounds.width - LXFit.fitFloat(325)) * 0.5
        menu.animateDuration = 0.25
        let view = UIView(frame: CGRect(x: 0, y: 0, width: LXFit.fitFloat(325), height: LXFit.fitFloat(300)))
        view.backgroundColor = UIColor.green
        menu.content = view
        menu.showFrom(from: btn)
        
        
        let menu1 = LXDrownUpMenuView()
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LXFit.fitFloat(300)))
        view1.backgroundColor = UIColor.purple
        menu1.content = view1
        menu1.animateDuration = 0.25

        menu1.show()
        
    }

}

