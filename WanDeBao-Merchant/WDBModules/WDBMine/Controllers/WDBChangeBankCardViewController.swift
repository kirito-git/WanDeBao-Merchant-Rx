//
//  WDBChangeBankCardViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class WDBChangeBankCardViewController: WDBBaseViewController {
    
    @IBOutlet weak var nextStepBtn: UIButton!
    @IBOutlet weak var bankCardTf: UITextField!
    @IBOutlet weak var cardOwerTf: UITextField!
    @IBOutlet weak var cardPhoneTf: UITextField!
    @IBOutlet weak var verifCodeTf: UITextField!
    @IBOutlet weak var getCodeBtn: YBCountDownButton!
    
    var viewModel = WDBMineViewModel()
    var bindBankCardVC = WDBBindBankCardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "添加银行卡"

        messageVaild()
    }
    
    func messageVaild() {
        let cardVaild: Observable<Bool> = self.bankCardTf.rx.text.orEmpty.map{ $0.count>=16 }
        let userNameVaild = self.cardOwerTf.rx.text.orEmpty.map{$0.count>0}.share(replay: 1)
        let phoneVaild = self.cardPhoneTf.rx.text.orEmpty.map{$0.count == 11}.share(replay: 1)
        let verifCodeVaild = self.verifCodeTf.rx.text.orEmpty.map{$0.count>=4}.share(replay: 1)
        _ = phoneVaild.bind(to: self.getCodeBtn.rx.isEnabled)
        let allVaild = Observable.combineLatest(cardVaild,userNameVaild,phoneVaild,verifCodeVaild){ $0 && $1 && $2 && $3 }
            .asObservable()
        _ = allVaild.bind(to: self.nextStepBtn.rx.isUserInteractionEnabled)
    }
    
    //获取验证码
    @IBAction func getCodeAction(_ sender: Any) {
        
        self.getCodeBtn.start()
        let phoneNum = self.cardPhoneTf.text ?? ""
        
        _ = self.viewModel.getHash(phoneNum: phoneNum).subscribe(onNext: {[weak self] (model) in
                //发送验证码
            _ = self?.viewModel.getCode(phoneNum: phoneNum, hashCode: model.hashCode ?? "").subscribe(onNext: { (model) in
                
                WDBAccountManager.sharedManger.sid = model.sid ?? ""
                WDBAccountManager.sharedManger.ID = model.ID ?? 0
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        }, onError: nil)
                
    }
    
    //确认
    @IBAction func confirmClick(_ sender: Any) {
        
        let cardNum = self.bankCardTf.text ?? ""
        let username = self.cardOwerTf.text ?? ""
        let mchId = "100001"
        let channelId = "LIANLIANPAY"
        let userId = WDBGlobalDataUserDefaults.getID()
        let ownerId = WDBGlobalDataUserDefaults.getOwnerId()
        let shopId = WDBGlobalDataUserDefaults.getShopID()
        let bankCard = cardNum
        let bankUsername = username
        let params = ["mchId":mchId,"channelId":channelId,"userId":userId,"ownerId":ownerId,"shopId":shopId,"bankCard":bankCard,"bankUsername":bankUsername] as [String : Any]
        _ = self.viewModel.userBindBankCard(params: params).subscribe(onNext: { (model) in
            print("绑定成功！")
            self.showSuccessAlert()
        }, onError: { (error) in
            print(error)
            SVProgressHUD.showError(withStatus: "绑定失败！")
        }, onCompleted: nil, onDisposed: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController.init(title: "提示", message: "绑定成功", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
