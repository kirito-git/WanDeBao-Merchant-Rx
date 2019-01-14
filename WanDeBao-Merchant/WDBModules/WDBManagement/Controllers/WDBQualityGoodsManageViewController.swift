//
//  WDBQualityGoodsManageViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import RxDataSources
import RxCocoa
import RxSwift
import SVProgressHUD

class WDBQualityGoodsManageViewController: WDBBaseViewController {

    //最新／精品
    var isQuality:Bool!
    func passValues (isquality:Bool) {
        isQuality = isquality
    }
    
    var tableView:UITableView!
    var footerView:UILabel!
    var confirmButton:UIButton!
    var viewModel:WDBProductManageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = isQuality ? "精品管理" : "新品管理"
        
        setupSubviews()
        setupFooterView()
        setupBottomView()
        setupRefresh()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //添加页面返回时需要请求一下
        if self.viewModel.viewdidLoad.value {
            self.viewModel.refreshRequest.onNext("request")
        }
    }
    
    func setupSubviews() {
        tableView = UITableView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH), style: .plain)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.rowHeight = 50
        tableView.register(WDBQualityGoodsManageCell.self, forCellReuseIdentifier: "WDBQualityGoodsManageCell")
        self.view.addSubview(tableView)
        _ = tableView.rx.setDelegate(self)
    }
    
    func bindViewModel() {
        
        //创建viewModel
        viewModel = WDBProductManageViewModel(input:(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver(),isQuality:self.isQuality))
        
        //绑定tableview
        _ = viewModel.products.bind(to: tableView.rx.items){ (tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WDBQualityGoodsManageCell") as! WDBQualityGoodsManageCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let model = element
            cell.foodNameLab?.text = model.name
            return cell
        }
        
        //获取删除项的索引
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            print("删除项的indexPath为：\(indexPath)")
            //调用删除接口
            _ = self?.viewModel.deleteProduct(row: indexPath.row).subscribe(onNext:{ response in
                if let resp:Int = response as? Int {
                    if resp == 1 {
                        SVProgressHUD.showSuccess(withStatus: "删除成功！")
                        var items = self?.viewModel.products.value
                        items?.remove(at: indexPath.row)
                        self?.viewModel.products.accept(items ?? [])
                    }
                }else {
                    SVProgressHUD.showError(withStatus: "删除失败！")
                }
            })
        }).disposed(by: disposeBag)
        
        //停止刷新绑定
        viewModel.endHeaderRefreshing
            .drive(self.tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        //绑定跳转
        _ = confirmButton.rx.tap.subscribe(onNext:{
            self.viewModel.viewdidLoad.value = true
            navigator.push(NavigatorURLQualityGoodsAdd, context:self.isQuality)
        })
        
    }
    
    func setupRefresh() {
        //设置头部刷新控件
        let headerRefresh = MJRefreshNormalHeader()
        headerRefresh.lastUpdatedTimeLabel.isHidden = true
        headerRefresh.stateLabel.isHidden = true
        self.tableView.mj_header = headerRefresh
    }

    func setupFooterView() {
        footerView = UILabel()
        footerView.frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:40)
        footerView.text = "（至多上传十二款）"
        footerView.textColor = DetailTextColor
        footerView.font = UIFontWithSize(size: 14)
        footerView.textAlignment = NSTextAlignment.center
        self.tableView.tableFooterView = footerView
    }
    
    func setupBottomView() {
        confirmButton = UIButton()
        confirmButton.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        confirmButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        confirmButton.titleLabel?.font = UIFontWithSize(size: 14)
        confirmButton.backgroundColor = UIColor_MainOrangeColor
        confirmButton.setTitle(isQuality ? "+添加精品" : "+添加新品", for:.normal)
        self.view.addSubview(confirmButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//tableView代理实现
extension WDBQualityGoodsManageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
