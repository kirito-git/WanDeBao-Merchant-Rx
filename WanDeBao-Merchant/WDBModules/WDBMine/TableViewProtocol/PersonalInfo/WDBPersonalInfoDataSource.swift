//
//  WDBPersonalInfoDataSource.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Kingfisher

class WDBPersonalInfoDataSource: NSObject, UITableViewDataSource {
    
    public lazy var dataDic = [String:Any]()
//    var avatarCell: WDBChangeAvatarCell?
//    var phoneCell: WDBChangePhoneCell?
//    var weChatCell: WDBChangePhoneCell?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = WDBChangeAvatarCell()
            if (dataDic["avatarUrl"] as? String) != nil  {
                let avatarUrl = dataDic["avatarUrl"]
                print(avatarUrl as!String)
                //cell.avatarImgView?.kf.setImage(with: URL.init(string:avatarUrl as! String))
                cell.avatarImgView.kf.setImage(with:URL.init(string:avatarUrl as! String) , placeholder: UIImage.init(named: "default_header"), options: nil, progressBlock: nil, completionHandler: nil)
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = WDBChangePhoneCell()
            var title  = dataDic["phoneNo"] as? String
            if title?.count == 0 {
                title = "未绑定手机号"
            }
            cell.setValueForValue(titleIcon: "mine_personalinfo_phoneicon", tip: "手机号", title:title ?? "", isChangePhoneNo: true)
            return cell
        }else {
            let cell = WDBChangePhoneCell()
            let bindStatus = dataDic["bindStatus"] as! Int
            var title = ""
            if bindStatus == 0 {
                title = "未绑定"
            }
            if bindStatus == 1 {
                title = "已绑定"
            }
            cell.setValueForValue(titleIcon: "mine_personalinfo_wechaticon", tip: "微信", title: title, isChangePhoneNo: false)
            return cell
        }
    
    }
    
    
}
