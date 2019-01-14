//
//  WDBRenewalDataSource.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBRenewalDataSource: NSObject,UITableViewDataSource {
    
    public var freeUseCell: WDBRenewalFreeUseCell!
    public var weChatPayCell: WDBRenewalPayTypeCell!
    public var aliPayCell: WDBRenewalPayTypeCell!
    public  typealias WDBOpenSevenDaysTryClourse = () -> Void
    public var openSevenDaysTryClourse: WDBOpenSevenDaysTryClourse?
    public var dataSource = [WDBProductModel]()
    public var isHaveSevenDaysTry: Bool = false
    public var selectIndex: Int?
    public var isSelectWeChatPay: Bool = false
    
    //开启7天试用
    func openSevenDaysTry(clourse: @escaping WDBOpenSevenDaysTryClourse) {
        self.openSevenDaysTryClourse = clourse
    }
    
    //MARK -UITableViewDataSourse
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataSource.count
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 && isHaveSevenDaysTry{
             freeUseCell = WDBRenewalFreeUseCell()
            _ = freeUseCell.freeToUseBtn.rx.tap.subscribe(onNext: { [weak self](event) in
                self?.openSevenDaysTryClourse!()
              })
              if self.dataSource.count > 0 {
                 freeUseCell.setData(data: self.dataSource[indexPath.row])
               }
             return freeUseCell
            }else {
                let productUseCell = WDBRenewalProductCell()
                
                if self.dataSource.count > 0 {
                    let model = self.dataSource[indexPath.row]
                 if let index = selectIndex, index == indexPath.row {
                    model.isSelectProduct = true
                 }else{
                    model.isSelectProduct = false
                }
                productUseCell.setData(data: model)
                }
                return productUseCell
            }
        }else if indexPath.section == 1 {
            let payTypeCell = WDBRenewalPayTypeCell()
            if indexPath.row == 0 {
                payTypeCell.setValueForView(image: "mine_wechaticon", title: "微信", isSelectWeChatPay:isSelectWeChatPay)
                 weChatPayCell = payTypeCell
            }else if indexPath.row == 1 {
                payTypeCell.setValueForView(image: "alipayicon", title: "支付宝", isSelectWeChatPay: false)
                aliPayCell = payTypeCell
            }
            return payTypeCell
        }
        return UITableViewCell()
    }
    
    
    

}
