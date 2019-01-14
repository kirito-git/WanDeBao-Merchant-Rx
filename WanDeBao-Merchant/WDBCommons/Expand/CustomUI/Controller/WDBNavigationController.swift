//
//  WDBNavigationController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/9.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAppearance()
        self.interactivePopGestureRecognizer?.delegate = self
       // setupBackButton()
    }
    
    
    func setupNavigationAppearance() {
        
        let appearance = UIBarButtonItem.appearance()
        
        
        //appearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: 0.0, vertical: -60), for: .default)
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.8)
        #if swift(>=4.0)
            self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)]
        #elseif swift(>=3.0)
            self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSFontAttributeName: UIFont.systemFont(ofSize: 17.0)];
        #endif
        self.navigationBar.tintColor = UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
        
//        self.navigationBar.backIndicatorImage = UIImage.init(named: "back")
//        self.navigationBar.backIndicatorTransitionMaskImage = UIImage.init(named: "back")
    }
    
    func setupBackButton() {
        
        let item = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        
    }
    
    @objc func backPage() {
        
        self.popViewController(animated: true)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if  self.viewControllers.count > 0 {
             viewController.hidesBottomBarWhenPushed = true
             //设置左边的返回按钮
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "common_back"), style: .plain, target: self, action: #selector(backPage))
//             let backButton = UIButton.init(type: .custom)
//             backButton.setImage(UIImage.init(named: "common_back"), for: .normal)
//             backButton.frame.size.width = 44
//             backButton.frame.size.height = 44
//             backButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 26)
//             backButton.addTarget(self, action: #selector(backPage), for: UIControlEvents.touchUpInside)
//             backButton.setTitle("", for: .normal)
//             self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
            
            if self.viewControllers[0].isKind(of: WDBMineViewController.self) {
                //此处为了避免我的页面隐藏NavigationBar出现向上滑动的情况
                let mineViewController = self.viewControllers[0] as? WDBMineViewController
                mineViewController?.isBackByPop = true
            }
            
        }
        super.pushViewController(viewController, animated: true)
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count <= 1 {
            return false
        }
        return true
    }
    
}

