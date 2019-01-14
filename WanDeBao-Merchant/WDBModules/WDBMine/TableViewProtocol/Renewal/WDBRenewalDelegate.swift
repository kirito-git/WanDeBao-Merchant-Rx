//
//  WDBRenewalDelegate.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/11.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit


class WDBRenewalDelegate: NSObject,UITableViewDelegate {
    
   public typealias WDBSelectPayTypeClourse = (_ payType: WDBPayType) -> Void
   public var selectPayTypeClourse: WDBSelectPayTypeClourse?
    
    public typealias WDBSelectProductClourse = (_ productModel: WDBProductModel, _ selectProductIndex: Int ) -> Void
   public var selectProductClourse: WDBSelectProductClourse?
    
   public var dataSource = [WDBProductModel]()
   public var isHaveSevenDaysTry: Bool = false
    
    //选择支付类型
    func selectPayType(clourse: @escaping WDBSelectPayTypeClourse) {
         self.selectPayTypeClourse = clourse
    }
    
   //选择商品
    func selectProduct(clourse: @escaping WDBSelectProductClourse) {
         self.selectProductClourse = clourse
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 100
        }else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  section == 0 {
            return 30
        }else{
          return 0.05
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 45
        }else{
             return 0.5
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let view = WDBRenewalFooterView()
            return view
        }else{
            let view = UIView()
            return view
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let view = UIView()
          let titleLabel = UILabel()
         view.backgroundColor = UIColor.white
          titleLabel.frame = CGRect.init(x: 10, y: 5, width: 80, height: 20)
          titleLabel.font = UIFont.systemFont(ofSize: 12)
        if section == 0 {
            titleLabel.text = "选择购买"
            view.addSubview(titleLabel)
        }
        
          return view
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  indexPath.section == 0 {
            
          if isHaveSevenDaysTry && indexPath.row == 0 {
                return
           }
            
          if let selectProductClourse = self.selectProductClourse {
            if dataSource.count > 0 {
                let selectModel = dataSource[indexPath.row]
                selectProductClourse(selectModel, indexPath.row)
            }
          }
        }
        
        if indexPath.section == 1 {
           guard let selectPayTypeClourse = self.selectPayTypeClourse else { return }
            
            if indexPath.row == 0 {
                 selectPayTypeClourse(WDBPayType.wxpay)
            }else if indexPath.row == 1 {
                selectPayTypeClourse(WDBPayType.alipay)
            }
        }
        
        
    }
    

    
}
