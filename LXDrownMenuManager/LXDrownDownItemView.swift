//
//  LXDrownDownItemView.swift
//  LXDrownMenuManager
//
//  Created by XL on 2020/7/30.
//

import UIKit
import LXFitManager

public typealias LXDrownDownItemViewCallBack = ((Int, LXDrownDownItemProtocol?) -> Void)

public protocol LXDrownDownItemProtocol {
    
    /// 标题
    var title: String { get set }
    
    /// 索引 或者 唯一标识
    var id: Int { get set }
}


public class LXDrownDownItemView: LXDrownMenuView {
        
     /// 单例模式
     public static let shared = LXDrownDownItemView()
     private init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.content = contentView
     }
     required public init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    public lazy var contentView: UIScrollView = {
        let contentView = UIScrollView()
        contentView.backgroundColor = UIColor.white
        return contentView
    }()
    
      public var itemViews = [LXItemView]()
      private var lastSelectItemView: LXItemView?
      public var itemViewCallBack: LXDrownDownItemViewCallBack?
      ///内容控制器vc
      public override var contentController: UIViewController? {
            didSet{ self.content = self.contentController?.view  }
       
      }
    
      /// 数据源
     public var itemModels: [LXDrownDownItemProtocol]? {
        didSet {
            guard let itemModels = itemModels else { return }
            
            var itemView: LXItemView
            for (index,itemModel) in itemModels.enumerated() {
               if index >= itemViews.count  { //判断是否在缓存里取
                itemView = LXItemView(type: .custom)
                   contentView.addSubview(itemView)
                   itemViews.append(itemView)
                itemView.addTarget(self, action: #selector(itemViewClick(_:)), for: .touchUpInside)
               }else {
                   itemView = itemViews[index]
               }
               //SinglePhotoView 信息配置
               itemView.tag = index
               itemView.isHidden = false
               itemView.itemModel = itemModel
               itemView.backgroundColorNormal = self.backgroundColorNormal
               itemView.textColorNormal = self.textColorNormal

           }

           //SinglePhotoView 视图控制
            for index in itemModels.count..<itemViews.count {
               let itemView = itemViews[index]
               itemView.isHidden = true
           }
        }
    }
    
    public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: LXFit.fitFloat(10), left: LXFit.fitFloat(10), bottom: LXFit.fitFloat(10), right: LXFit.fitFloat(10)) {
        didSet {  setNeedsLayout() }
    }
    public var rowMargin: CGFloat = LXFit.fitFloat(10)  {
        didSet {  setNeedsLayout() }
    }
    public var colMargin: CGFloat = LXFit.fitFloat(10)  {
        didSet {  setNeedsLayout() }
    }
    
    public var contentMargin: CGFloat = LXFit.fitFloat(20) {
        didSet {  setNeedsLayout() }
    }
    public var contentH: CGFloat = LXFit.fitFloat(26) {
        didSet {  setNeedsLayout() }
    }
    public var contentViewMaxH: CGFloat = LXFit.fitFloat(260)
    
    public var  backgroundColorSelect: UIColor = UIColor.red.withAlphaComponent(0.5) {
           didSet {
               itemViews.forEach { (itemView) in
                    if itemView == lastSelectItemView {
                        itemView.backgroundColorSelect = backgroundColorSelect
                    }
               }
           }
       }
       
       public var  backgroundColorNormal: UIColor  = UIColor.lightGray.withAlphaComponent(0.5) {
           didSet {
               itemViews.forEach { (itemView) in
                    if itemView != lastSelectItemView {
                        itemView.backgroundColorNormal = backgroundColorNormal
                    }
               }
           }
       }
    
       public var  textColorNormal: UIColor  = UIColor.lightGray.withAlphaComponent(0.5) {
           didSet {
                itemViews.forEach { (itemView) in
                     if itemView != lastSelectItemView {
                         itemView.textColorNormal = textColorNormal
                     }
                }
           }
       }
       public var  textColorSelect: UIColor  = UIColor.white {
           didSet {
                itemViews.forEach { (itemView) in
                 if itemView == lastSelectItemView {
                     itemView.textColorSelect = textColorSelect
                 }
               }
           }
       }
    
       public var  textFont: UIFont = UIFont.systemFont(ofSize: 15).fitFont {
           didSet {
                itemViews.forEach { (itemView) in
                    itemView.textFont = textFont
                }
                setNeedsLayout()
           }
       }

        public var  cornerRadius: CGFloat = LXFit.fitFloat(13) {
             didSet {
                 itemViews.forEach { (itemView) in
                     itemView.cornerRadius = cornerRadius
                 }
             }
         }
       
     
     public override func layoutSubviews() {
        super.layoutSubviews()
        var items = [LXItemView]()

        for (index,itemView) in itemViews.enumerated() {
            itemView.cornerRadius = cornerRadius
            let cH = self.frame.width - edgeInsets.left -  edgeInsets.right
            let itemW = min((itemView.titleLabel?.attributedText?.boundingRect(with: CGSize(width: cH , height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).width ?? 0) + contentMargin, cH)
            if index == 0 {
                itemView.frame = CGRect(x: edgeInsets.left, y: edgeInsets.top , width: min(itemW, itemW) , height: contentH)
            }else {
                
                var x = items.last!.frame.maxX + colMargin
                var y = items.last!.frame.minY
                if x + itemW + edgeInsets.right > self.frame.width {
                    x = edgeInsets.left
                    y = items.last!.frame.maxY + rowMargin
                }
                
                itemView.frame = CGRect(x:x, y: y , width: itemW , height: contentH)
            }
            items.append(itemView)
            ///默认选中
            if index == 0 { itemViewClick(itemView) }
            
        }
        
        if items.count > 0 {
            guard let c = content else {  return }
            self.containerView.frame =  CGRect(origin: CGPoint.zero, size: c.frame.size)
            contentView.contentSize = CGSize(width: 0, height: items.last!.frame.maxY + edgeInsets.bottom)
        }
    }
    
        ///内容view
       public override var content: UIView? {
            didSet{
                guard let content = self.content else {return}
                self.containerView.addSubview(content)
            }
        }

         ///销毁
        public override func dismiss() {
             UIView.animate(withDuration: animateDuration, animations: {
                 self.backgroundColor?.withAlphaComponent(0.0)
             }) {(finished) -> () in
                 self.removeFromSuperview()
             }
         }
    
    }


extension LXDrownDownItemView {
    
    @objc private func itemViewClick(_ itemView:LXItemView ){
        lastSelectItemView?.isSelected = false
        lastSelectItemView?.backgroundColorNormal = self.backgroundColorNormal
        lastSelectItemView?.textColorNormal = self.textColorNormal
        itemView.isSelected = true
        itemView.backgroundColorSelect = self.backgroundColorSelect
        itemView.textColorSelect = self.textColorSelect

        lastSelectItemView = itemView
        
        self.itemViewCallBack?(itemView.tag,itemView.itemModel)
    }
    
    ///显示 view 被点击的view
    public func showFrom(from view: UIView) {
        
        guard let rootView = aboveViewController?.view else {
            return
        }
        rootView.addSubview(self)
        let rect  = view.convert(view.bounds, to: rootView)
        self.frame = CGRect(x: 0, y: rect.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - rect.maxY)
        content?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: min(contentViewMaxH, UIScreen.main.bounds.height - rect.maxY))

        self.backgroundColor?.withAlphaComponent(0.0)
        UIView.animate(withDuration: animateDuration) {
            self.backgroundColor?.withAlphaComponent(self.viewAlpha)
        }
    }
    
    public func setHandle(itemViewCallBack: LXDrownDownItemViewCallBack?) {
        self.itemViewCallBack = itemViewCallBack
    }
}

public class LXItemView: UIButton {
    
    public var  backgroundColorSelect: UIColor? {
        didSet {
            guard let backgroundColorSelect = backgroundColorSelect else { return }
            backgroundColor = backgroundColorSelect
        }
    }
    
    public var  backgroundColorNormal: UIColor? {
        didSet {
            guard let backgroundColorNormal = backgroundColorNormal else { return }
            backgroundColor = backgroundColorNormal
        }
    }
    public var  textColorNormal: UIColor? {
        didSet {
            guard let textColorNormal = textColorNormal else { return }
            setTitleColor(textColorNormal, for: .normal)
        }
    }
    public var  textColorSelect: UIColor? {
        didSet {
            guard let textColorSelect = textColorSelect else { return }
            setTitleColor(textColorSelect, for: .selected)
        }
    }
    public var  textFont: UIFont? {
        didSet {
            guard let textFont = textFont else { return }
            titleLabel?.font = textFont
        }
    }

    public var  cornerRadius: CGFloat? {
          didSet {
              guard let cornerRadius = cornerRadius else { return }
              layer.cornerRadius = cornerRadius
              clipsToBounds = true
          }
      }
    
    public var itemModel: LXDrownDownItemProtocol? {
        didSet {
            guard let itemModel = itemModel else { return }
            setTitle(itemModel.title, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        adjustsImageWhenHighlighted = false
        titleLabel?.font = UIFont.systemFont(ofSize: 15).fitFont
        titleLabel?.lineBreakMode = NSLineBreakMode.byTruncatingTail
        setTitleColor(textColorNormal, for: .normal)
        setTitleColor(textColorSelect, for: .selected)
        titleLabel?.font = textFont
        backgroundColor = backgroundColorNormal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
