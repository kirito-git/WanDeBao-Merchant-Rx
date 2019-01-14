//
//  WDBMessageDetailVC.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/24.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBMessageDetailVC: WDBBaseViewController {

    var model:WDBMessageModel?
    var detailView:WDBMessageDetailView!
    var viewModel = WDBMessageDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息内容"
        detailView = WDBMessageDetailView.init(frame: self.view.frame)
        self.view.addSubview(detailView)
        
        bindViewModel()
    }
    
    func bindViewModel() {
        _ = self.viewModel.title.asObservable().bind(to: self.detailView.titleLab.rx.text)
        _ = self.viewModel.content.asObservable().bind(to: self.detailView.contentLab.rx.text)
        _ = self.viewModel.creatTime.asObservable().bind(to: self.detailView.dateLab.rx.text)
        
        let id = String(describing: model?.Id ?? 0)
        let params = ["id":id]
        _ = viewModel.messageDetail(dic: params).subscribe(onNext: { (response) in
            let dic = response as! [String:Any]
            let content = dic["content"] as! String
            self.viewModel.title.value = self.model?.title ?? "无标题"
            self.viewModel.content.value = content 
            self.viewModel.creatTime.value = self.model?.createTimeString ?? ""
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
