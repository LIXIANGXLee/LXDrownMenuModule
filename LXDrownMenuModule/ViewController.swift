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
        self.view.backgroundColor = UIColor.white
        
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.red
        btn.frame = CGRect(x: LXFit.fitFloat(250), y: 100, width: LXFit.fitFloat(100), height: 100)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnClick(_:)), for: UIControl.Event.touchUpInside)
        
        
        let btn1 = UIButton(type: .custom)
               btn1.backgroundColor = UIColor.red
               btn1.frame = CGRect(x: LXFit.fitFloat(100), y: 100, width: LXFit.fitFloat(100), height: 100)
               view.addSubview(btn1)
               btn1.addTarget(self, action: #selector(btnClick1(_:)), for: UIControl.Event.touchUpInside)
               
        
    }

    
    @objc func btnClick(_ btn: UIButton) {
        
//       let menu = LXDrownDownMenuView()
////        menu.bgImage = UIImage(named: "timg")
//        menu.letMargin = (UIScreen.main.bounds.width - LXFit.fitFloat(325)) * 0.5
//        menu.animateDuration = 0.25
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: LXFit.fitFloat(325), height: LXFit.fitFloat(300)))
//        view.backgroundColor = UIColor.green
//        menu.content = view
//        menu.showFrom(from: btn)
//
        
//        let menu1 = LXDrownUpMenuView()
//        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LXFit.fitFloat(300)))
////        view1.backgroundColor = UIColor.white
//
////        menu1.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        menu1.content = view1
//        menu1.animateDuration = 0.25
//
//        menu1.show()
//
        let ii = ["fgfhkvjkgsdgjjhjkg","jkgjkdg sjgrere","fgfhkvj","fgfhkv","fgfhkvjdsdskgsdgsjg","fgfhkvjkgsdgdgfdgfdgfdgsjg","fgfhkvjkgsdg sjg","fgfhkvjkgsdg sjg","fgfhkv433545453jkgsdg sjg","fgfhkvjkgsdg4343sjg","fgffdsfdsfdsfdhkvjkgsdg sjg","fgfhkvj","fgfhkv","fgfhkvjdsdskgsdgsjg","fgfhkvjkgsdgdgfdgfdgfdgsjg","fgfhkvjkgsdg sjg","fgfhkvjkgsdg sjg","fgfhkv433545453jkgsdg sjg","fgfhkvjkgsdg4343sjg","fgffdsfdsfdsfdhkvjkgsdg sjg","fgfhkvj","fgfhkv","fgfhkvjdsdskgsdgsjg","fgfhkvjkgsdgdgfdgfdgfdgsjg","fgfhkvjkgsdg sjg","fgfhkvjkgsdg sjg","fgfhkv433545453jkgsdg sjg","fgfhkvjkgsdg4343sjg","fgfhkvjdsdskgsdgsjg","fgfhkvjkgsdgdgfdgfdgfdgsjg","fgfhkvjkgsdg sjg","fgfhkvjkgsdg sjg","fgfhkv433545453jkgsdg sjg","fgfhkvjkgsdg4343sjg","fgffdsfdsfdsfdhkvjkgsdg sjg","fgfhkvj","fgfhkv","fgfhkvjdsdskgsdgsjg","fgfhkvjkgsdgdgfdgfdgfdgsjg","fgfhkvjkgsdg sjg","fgfhkvjkgsdg sjg","fgfhkv433545453jkgsdg sjg","fgfhkvjkgsdg4343sjg","fgffdsfdsfdsfdhkvjkgsdg sjg","fgfhkvj","fgfhkv","fgfhkvjdsdskgsdgsjg","fgfhkvjkgsdgdgfdgfdgfdgsjg","fgfhkvjkgsdg sjg","fgfhkvjkgsdg sjg","fgfhkv433545453jkgsdg sjg","fgfhkvjkgsdg4343sjg"]
        var itemModels = [ItemModel]()
        for i in 0..<ii.count {
            let itemModel = ItemModel()
            itemModel.title = ii[i]
            itemModels.append(itemModel)
        }
        
        let menu1 = LXDrownDownItemView.shared
        
        menu1.itemModels = itemModels

        menu1.backgroundColorNormal = UIColor.red
        menu1.backgroundColorSelect = UIColor.black
        
        menu1.textColorSelect = UIColor.green
        menu1.textColorNormal = UIColor.white
        
        menu1.viewAlpha = 0.2
        menu1.selectIndex = 1
        menu1.setHandle { (index, model) in
            print("=====\(index)==\(model?.title)")
        }
        menu1.showFrom(from: btn,on:self.view,isAutoStretch: true)
            
        
        menu1.itemH = LXFit.fitFloat(30)
               menu1.textFont = UIFont.systemFont(ofSize: 12).fitFont
               menu1.contentViewMaxH = 400
    }
    @objc func btnClick1(_ btn: UIButton) {
           
         let ii = ["fgfhkvjkgsdgjjhjkg","jkgjkdg sjgrere","fgfhkvj",]
           var itemModels = [ItemModel]()
           for i in 0..<ii.count {
               let itemModel = ItemModel()
               itemModel.title = ii[i]
               itemModels.append(itemModel)
           }
           
        let menu1 = LXDrownDownItemView.shared
           
           menu1.itemModels = itemModels

           menu1.backgroundColorNormal = UIColor.red
           menu1.backgroundColorSelect = UIColor.black
           
           menu1.textColorSelect = UIColor.green
           menu1.textColorNormal = UIColor.white
           
        
           menu1.itemH = LXFit.fitFloat(30)
           menu1.textFont = UIFont.systemFont(ofSize: 12).fitFont
           menu1.contentViewMaxH = 400
           menu1.setHandle { (index, model) in
//               print("=====\(index)==\(model?.title)")
           }
        menu1.selectIndex = 2

        menu1.viewAlpha = 0.2

                   menu1.showFrom(from: btn,on:self.view,isAutoStretch: true)
               
           
           menu1.itemH = LXFit.fitFloat(30)
           menu1.textFont = UIFont.systemFont(ofSize: 12).fitFont
           menu1.contentViewMaxH = 400
       }

}

class ItemModel: LXDrownDownItemProtocol {
    var title: String = "hahfdsfdscah"
    
    var id: Int = 0
    
    
}
