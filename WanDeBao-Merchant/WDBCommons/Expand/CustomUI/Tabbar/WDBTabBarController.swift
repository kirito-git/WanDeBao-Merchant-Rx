//
//  WDBTabBarController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/9.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class WDBTabBarController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let homePageVC = navigator.viewController(for: NavigatorURLHomePage)
        homePageVC?.navigationItem.title = "首页";
        
        let homePageNavi = WDBNavigationController.init(rootViewController: homePageVC!);
        homePageNavi.hidesBottomBarWhenPushed = true
        
        let managementVC = navigator.viewController(for: NavigatorURLManagement)
        managementVC?.navigationItem.title = "管理";
        let managementNavi = WDBNavigationController.init(rootViewController: managementVC!);
        
        let messageVC = navigator.viewController(for: NavigatorURLMessage)
        messageVC?.navigationItem.title = "消息";
        let messageNavi = WDBNavigationController.init(rootViewController: messageVC!);
        
        let mineVC = navigator.viewController(for: NavigatorURLMine)
        mineVC?.navigationItem.title = "我的";
        let mineNavi = WDBNavigationController.init(rootViewController: mineVC!);
        
        
        homePageVC?.tabBarItem = ESTabBarItem.init(WDBBouncesContentView(), title: "首页", image: UIImage.init(named: "tabbar_homepage_normal"), selectedImage: UIImage.init(named: "tabbar_homepage_select"), tag:0);
        managementVC?.tabBarItem = ESTabBarItem.init(WDBBouncesContentView(), title: "管理", image: UIImage.init(named: "tabbar_management_normal"), selectedImage: UIImage.init(named: "tabbar_management_select"), tag:1);
        messageVC?.tabBarItem = ESTabBarItem.init(WDBBouncesContentView(), title: "消息", image: UIImage.init(named: "tabbar_message_normal"), selectedImage: UIImage.init(named: "tabbar_message_select"), tag:2);
        mineVC?.tabBarItem = ESTabBarItem.init(WDBBouncesContentView(), title: "我的", image: UIImage.init(named: "tabbar_mine_normal"), selectedImage: UIImage.init(named: "tabbar_mine_select"), tag:3);
        
        //if let tabBarItem = messageVC.tabBarItem as? ESTabBarItem {
             //tabBarItem.badgeValue = "99+";
        //}
        self.viewControllers = [homePageNavi, managementNavi, messageNavi, mineNavi];
        self.title = "首页";
    }
    

}
