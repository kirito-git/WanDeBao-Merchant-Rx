//
//  WDBLoginViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class WDBLoginViewController: UIViewController {
    
    lazy var loginView: WDBLoginView = WDBLoginView();
    var viewModel:WDBLoginViewModel!
    let disposebag = DisposeBag()
    var sid: String = ""
    private let appCode = "app_wdb"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = WDBLoginViewModel()
        loginView.frame = UIScreen.main.bounds;
        self.view.addSubview(loginView);
        self.bindViewModel()
        
    }
    
    func bindViewModel() {
      
     //绑定手机号
    loginView.phoneNoTextField.rx.text.orEmpty.bind(to: (viewModel?.phoneNumber)!).disposed(by: disposebag)
     //绑定验证码
      loginView.vCodeTextField.rx.text.orEmpty.bind(to: viewModel.code).disposed(by: disposebag)
      _ = viewModel.validedLoginEnable.bind(to: loginView.loginBtn.rx.isEnabled)
      _ = viewModel.valideGetCodeEnable.bind(to: loginView.getCodeBtn.rx.isEnabled)
        
     //获取验证码
     _ = loginView.getCodeBtn.rx.tap.subscribe(onNext: { [weak self] in
        self?.loginView.getCodeBtn.start()
        _ = self?.viewModel.getHash().subscribe(onNext: {[weak self] (model) in
             _ = self?.viewModel.getCode(hashCode: model.hashCode ?? "").subscribe(onNext: { (model) in

                 WDBAccountManager.sharedManger.sid = model.sid ?? ""
                 YBProgressHUD.showTipMessage(text: "验证码发送成功")
            }, onError: { (error) in

            })
        }, onError: {(error) in

        })
     })
        
     //验证码登录
      _ = loginView.loginBtn.rx.tap.subscribe(onNext: { [weak self] in
        
        let sid = WDBAccountManager.sharedManger.sid
        _ = self?.viewModel.verifyCodeLogin(sid: sid ?? "", appCode:self?.appCode ?? "").subscribe(onNext: { model in
            
        //保存数据
           WDBCommonHelper.shared.saveData(loginInfo: model)
        //检查是否资料审核通过
            if let phone = model.userInfo?.phone, let userId = model.userInfo?.ID {
                WDBCommonHelper.shared.dealWithCheckStatus(phone: phone, userId: userId, viewController: self!)
            }
        })
        
       })
        
       //微信登录
       _ = loginView.weChatLoginBtn.rx.tap.subscribe(onNext: { (result) in
           WDBWeChatViewModel.shared.weChatClickWithOperationType(operationType: .login, viewController: self)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposebag)
      
    }

    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(true, animated: true)
        //检测是否安装微信
        
        if WXApi.isWXAppInstalled() {
            loginView.weChatLoginBtn.isHidden = false
            loginView.separatorLineImgView.isHidden = false
        }else{
            loginView.weChatLoginBtn.isHidden = true
            loginView.separatorLineImgView.isHidden = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: true)
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
