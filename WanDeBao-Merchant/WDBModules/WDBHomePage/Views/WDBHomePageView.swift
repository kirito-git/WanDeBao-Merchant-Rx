//
//  WDBHomePageView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import swiftScan
//LBXScanViewControllerDelegate
class WDBHomePageView: UIView{

    var viewModel = WDBHomePageViewModel()
    var homeTableView:UITableView!
    var noteView:WDBHomePageNotebook!
    
    var scanStyle:LBXScanViewStyle!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        
        homeTableView = UITableView()
        homeTableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-50-kNavibarH-iPhoneXBottomBarH)
        homeTableView.backgroundColor = UIColor.groupTableViewBackground
        homeTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        homeTableView.tableFooterView = UIView()
        self.addSubview(homeTableView)
        
        homeTableView.register(WDBHomePageCell1.self, forCellReuseIdentifier: "WDBHomePageCell1")
        homeTableView.register(WDBHomePageCell2.self, forCellReuseIdentifier: "WDBHomePageCell2")
        homeTableView.register(WDBHomePageCell3.self, forCellReuseIdentifier: "WDBHomePageCell3")
        homeTableView.register(WDBHomePageCell4.self, forCellReuseIdentifier: "WDBHomePageCell4")

        noteView = WDBHomePageNotebook.init(frame:CGRect.zero)
        homeTableView.tableHeaderView = noteView
        
        setScanStyle()
    }
    
    func setScanStyle() {
        //设置扫码区域参数
        var style = LBXScanViewStyle()
        
        style.centerUpOffset = 60;
        style.xScanRetangleOffset = 30;
        
        if UIScreen.main.bounds.size.height <= 480
        {
            //3.5inch 显示的扫码缩小
            style.centerUpOffset = 40;
            style.xScanRetangleOffset = 20;
        }
        
        style.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
        
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 2.0;
        style.photoframeAngleW = 16;
        style.photoframeAngleH = 16;
        
        style.isNeedShowRetangle = false;
        
        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid;
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_full_net")
        
        self.scanStyle = style
    }
    
    
    /*
    
    @objc func scanClick() {
        //点击扫描
        scanWithZhiFuBaoStyle()
    }
     
    //MARK: ---模仿支付宝------
    func scanWithZhiFuBaoStyle()
    {
        //设置扫码区域参数
        var style = LBXScanViewStyle()
        
        style.centerUpOffset = 60;
        style.xScanRetangleOffset = 30;
        
        if UIScreen.main.bounds.size.height <= 480
        {
            //3.5inch 显示的扫码缩小
            style.centerUpOffset = 40;
            style.xScanRetangleOffset = 20;
        }
        
        style.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)
        
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 2.0;
        style.photoframeAngleW = 16;
        style.photoframeAngleH = 16;
        
        style.isNeedShowRetangle = false;
        
        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid;
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_full_net")
        
        let vc = LBXScanViewController();
        vc.title = "扫一扫"
        vc.scanResultDelegate = self
        vc.scanStyle = style
        parentControl.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK --LBXScanViewControllerDelegate
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        print("扫码结果===",scanResult.strScanned ?? "")
        
        parentControl.hidesBottomBarWhenPushed = true
        let scanResultVC = WDBScanResultViewController()
        scanResultVC.scanResultString = scanResult.strScanned ?? ""
        parentControl.navigationController?.pushViewController(scanResultVC, animated: true)
        parentControl.hidesBottomBarWhenPushed = false
    }
    */

}
