//
//  WDBExpandViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBExpandViewController: WDBBaseViewController {
    
    var viewModel = WDBGeneralizeInfoViewModel()
    var expandView:WDBExpandView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推广详情"
        
        expandView = WDBExpandView.init(frame: self.view.frame)
        expandView.parentControl = self
        self.view.addSubview(expandView)
        
        bindViewModel()
    }
    
    func bindViewModel() {
        //获取推广详情
        let tuple = DateFormatTool.getTodayStartAndEndTimeStamp()
        let startTime = String(format:"%.0f",tuple.0 * 1000)
        let endTime = String(format:"%.0f",tuple.1 * 1000)
        let shopid = WDBGlobalDataUserDefaults.getShopID()
        let params = ["shopId":shopid,"startTime":startTime,"endTime":endTime]
        _ = viewModel.generalizeInfo(dic: params).subscribe(onNext: { (response) in
            print(response)
            self.expandView.headerView.model = response as WDBGeneralizeModel!
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
