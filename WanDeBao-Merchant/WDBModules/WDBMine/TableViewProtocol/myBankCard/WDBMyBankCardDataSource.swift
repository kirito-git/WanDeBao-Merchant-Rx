//
//  WDBMyBankCardDataSource.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/17.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit


class WDBMyBankCardDataSource: NSObject, UITableViewDataSource {

    public var dataArray:[WDBMyBankCardInfoModel]?

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WDBMyBankCardCell") as? WDBMyBankCardCell
        let model = dataArray![indexPath.row]
        cell?.bankNameLab.text = model.bankName ?? ""
        cell?.bankOwerLab.text = "持卡人：\(model.bankUsername ?? "")"
        cell?.bankCardLab.text = model.bankCard ?? ""
        return cell!
    }
    
    
    
}
