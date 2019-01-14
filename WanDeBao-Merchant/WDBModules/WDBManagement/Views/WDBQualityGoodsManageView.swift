//
//  WDBQualityGoodsManageView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SVProgressHUD

class WDBQualityGoodsManageView: UIView,UITableViewDelegate,UITableViewDataSource ,DZNEmptyDataSetDelegate, DZNEmptyDataSetSource{

    var dataArray: [WDBProductModel]!
    
    var parentControl:WDBQualityGoodsManageViewController!
    var viewModel:WDBProductManageViewModel!
    var goodsTableView:UITableView!
    var confirmButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        dataArray = [WDBProductModel]()
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubViews() -> Void {
        
        goodsTableView = UITableView()
        goodsTableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH)
        goodsTableView.backgroundColor = UIColor.groupTableViewBackground
        goodsTableView.delegate = self
        goodsTableView.dataSource = self
        self.addSubview(goodsTableView)
        goodsTableView.register(WDBQualityGoodsManageCell.self, forCellReuseIdentifier: "WDBQualityGoodsManageCell")
        goodsTableView.emptyDataSetDelegate = self
        goodsTableView.emptyDataSetSource = self
        
        //foterview
        setupFooterView()
        
        setupBottomView()
    }
    
    func setupFooterView() -> Void {
        
        let footerView:UILabel! = UILabel()
        footerView.frame = CGRect(x:0,y:0,width:self.frame.size.width,height:40)
        footerView.text = "（至多上传十二款）"
        footerView.textColor = DetailTextColor
        footerView.font = UIFontWithSize(size: 14)
        footerView.textAlignment = NSTextAlignment.center
        goodsTableView.tableFooterView = footerView

    }
    
    func setupBottomView() -> Void {
        
        confirmButton = UIButton()
        confirmButton.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        confirmButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        confirmButton.titleLabel?.font = UIFontWithSize(size: 14)
        confirmButton.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(confirmButton)
        
        confirmButton.addTarget(self, action: #selector(confirmClick), for: UIControlEvents.touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WDBQualityGoodsManageCell", for: indexPath) as! WDBQualityGoodsManageCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let model = dataArray![indexPath.row]
        cell.foodNameLab?.text = model.name
        return cell
    }
    
    //tableview允许编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            //选择了删除
            let model = self.dataArray[indexPath.row] as WDBProductModel
            let shopid = WDBGlobalDataUserDefaults.getShopID()
            let discountId = String(describing: model.productId ?? 0)
            let params = ["shopId":shopid,"ids":discountId]
//            _ = viewModel.deleteProduct(dic: params).subscribe(onNext: { (response) in
//                if let resp:Int = response as? Int {
//                    if resp == 1 {
//                        SVProgressHUD.showSuccess(withStatus: "删除成功！")
//                        //删除此行
//                        self.dataArray.remove(at: indexPath.row)
//                        //刷新
//                        self.goodsTableView.reloadData()
//                    }
//                }else {
//                    SVProgressHUD.showError(withStatus: "删除失败！")
//                }
//            }, onError: nil, onCompleted: nil, onDisposed: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    @objc func confirmClick(_ button:UIButton) -> Void {
        //let addGoodsVC = WDBQualityGoodsAddViewController()
        //addGoodsVC.passValues(isquality: parentControl.isQuality)
        //parentControl.navigationController?.pushViewController(addGoodsVC, animated: true)
        navigator.push(NavigatorURLQualityGoodsAdd, context:parentControl.isQuality)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "暂无商品", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
    }
}
