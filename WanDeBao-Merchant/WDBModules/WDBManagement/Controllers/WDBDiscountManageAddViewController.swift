//
//  WDBDiscountManageAddViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/30.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WDBDiscountManageAddViewController: UIViewController {

    @IBOutlet weak var typeName: UILabel!
    //满减数据
    @IBOutlet weak var dTf_mj_m: UITextField!
    @IBOutlet weak var dTf_mj_j: UITextField!
    //免单数据
    @IBOutlet weak var dTf_md_price: UITextField!
    //实物名
    @IBOutlet weak var dTf_sw_name: UITextField!
    //折扣数
    @IBOutlet weak var dTf_zk_num: UITextField!
    //有效期
    @IBOutlet weak var dTf_limitDay: UITextField!
    //数量
    @IBOutlet weak var dTf_Numer: UITextField!
    //免单显示
    @IBOutlet weak var dContent_md: UIView!
    //实物显示
    @IBOutlet weak var dCount_sw: UIView!
    //折扣显示
    @IBOutlet weak var dCount_zk: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    //修改还是添加操作 修改需要传过来model
    var isActionAdd:Bool!
    var discountModel:WDBDiscountModel!
    
    var viewModel:WDBDiscountManageAddViewModel!
    var current_Type:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = isActionAdd ? "添加优惠券" : "修改优惠券"
        self.confirmButton.setTitle(self.title, for: UIControlState.normal)
        resetSubviews()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel = WDBDiscountManageAddViewModel()
        
        _ = self.dTf_limitDay.rx.textInput <-> self.viewModel.limitTime
        _ = self.dTf_Numer.rx.textInput <-> self.viewModel.num
        //满减
        _ = self.dTf_mj_m.rx.textInput <-> self.viewModel.downlimitSum
        _ = self.dTf_mj_j.rx.textInput <-> self.viewModel.downSum
        //免单
        _ = self.dTf_md_price.rx.textInput <-> self.viewModel.mdPrice
        //赠品
        _ = self.dTf_sw_name.rx.textInput <-> self.viewModel.swName
        //折扣
        _ = self.dTf_zk_num.rx.textInput <-> self.viewModel.factorValue
        
        //优惠券类型
        self.viewModel.discountType.value = current_Type
        
        _ = self.confirmButton.rx.tap
            .throttle(0.1, scheduler: MainScheduler.instance)
            .flatMap{self.viewModel.getRequestParams()}
            .filter{_ in
                if !self.viewModel.inputVaild.value {
                    self.showAlert(message:"请填写完整信息！",isBack:false)
                    return false
                }
                return true
            }
            .flatMapLatest{ params in
                self.viewModel.discountAdd(params: params)
            }
            .subscribe(onNext:{ response in
                //结果返回
                let respData:[String:Any] = response as! [String:Any]
                if respData["discount"] == nil {
                    self.showAlert(message: respData["error_mesg"] as! String,isBack: false)
                }else {
                    //成功
                    self.showAlert(message: "添加成功！",isBack: true)
                }
            })
    }

    func resetSubviews() {
        self.dContent_md.isHidden = true
        self.dCount_zk.isHidden = true
        self.dCount_sw.isHidden = true
        var type = ""
        if current_Type == "8" {
            self.dContent_md?.isHidden = false
            type = "优惠券类型：免单券"
        }else if current_Type == "5" {
            type = "优惠券类型：满减券"
        }else if current_Type == "4" {
            self.dCount_sw?.isHidden = false
            type = "优惠券类型：赠品券"
        }else if current_Type == "6" {
            self.dCount_zk?.isHidden = false
            type = "优惠券类型：折扣券"
        }
        self.typeName.text = type
    }
    
    func showAlert(message:String, isBack:Bool) {
        if isBack {
            navigator.open(NavigatorURLAlert + "?title=提示&message=\(message)&isBack=\(isBack)", context: ["fromViewController":self])
        }else {
             navigator.open(NavigatorURLAlert + "/" + "?title=提示&message=\(message)",context: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
