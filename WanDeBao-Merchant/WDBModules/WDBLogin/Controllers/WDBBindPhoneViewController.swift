//
//  WDBBindPhoneViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import RxCocoa

enum WDBPhoneNoAndCodeControllerType:Int {
    case bindPhoneNo = 0
    case verifyOldPhone
    case changePhoneNumber
}

class WDBBindPhoneViewController: WDBBaseViewController {

    public var phoneNoAndCodeControllerType: WDBPhoneNoAndCodeControllerType?
    public var userCert:String?
    public var oldPhoneNumber:String?
    var viewModel: WDBLoginViewModel?
    let disposebag = DisposeBag()
    
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var getCodeBtn: YBCountDownButton!
    @IBOutlet weak var okBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
        bindViewModel()
    }
    
    func initController() {
        
    switch phoneNoAndCodeControllerType {
      case .bindPhoneNo?:
        self.navigationItem.title = "绑定手机"
        self.okBtn.setTitle("确认绑定", for: .normal)
         break
      case .verifyOldPhone?:
         self.navigationItem.title = "验证旧手机号"
         self.okBtn.setTitle("下一步", for: .normal)
         break
      case .changePhoneNumber?:
          self.navigationItem.title = "修改手机号"
          self.phoneNoTF.placeholder = "请输入您的新手机号"
          self.okBtn.setTitle("确认修改", for: .normal)
        break
        default:
            break
        }
    
    }
    
    func bindViewModel() {
       self.viewModel = WDBLoginViewModel()
        
       self.phoneNoTF.rx.text.orEmpty.bind(to: (self.viewModel?.phoneNumber)!).disposed(by: disposebag)
       self.codeTF.rx.text.orEmpty.bind(to: (self.viewModel?.code)!).disposed(by: disposebag)
       _ = self.viewModel?.valideGetCodeEnable.bind(to: self.getCodeBtn.rx.isEnabled)
       _ = self.viewModel?.validedLoginEnable.bind(to: self.okBtn.rx.isEnabled)
        
    }
    
    @IBAction func getCodeAction(_ sender: YBCountDownButton) {
        
        self.getCodeBtn.start()
        _ = self.viewModel?.getHash().subscribe(onNext: {[weak self] (model) in
             _ = self?.viewModel?.getCode(hashCode: model.hashCode ?? "").subscribe(onNext: { (model) in
                 WDBAccountManager.sharedManger.sid = model.sid ?? ""
                 WDBAccountManager.sharedManger.ID = model.ID ?? 0
            }, onError: { (error) in
                
            })
            }, onError: {(error) in
                
        })
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        
        switch phoneNoAndCodeControllerType {
        case .bindPhoneNo?:
            //绑定手机号
            _ = self.viewModel?.bindPhone().subscribe(onNext: {[weak self](userInfo) in
                //绑定成功跳转到主界面
                
                //保存Token和RefreshToken
                self?.saveData(userInfo: userInfo)
                
                if let phone = userInfo.phone, let userId = userInfo.ID {
                    WDBCommonHelper.shared.dealWithCheckStatus(phone: phone, userId: userId, viewController: self!)
                }
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)
             break
        case .verifyOldPhone?:
            //验证旧手机号
           _ = self.viewModel?.verifyOldPhoneNo().subscribe(onNext: { [weak self](response) in
            
             if let usercert = JSON.init(response)["usercert"].string {
                let paramDic = ["type": "\(WDBPhoneNoAndCodeControllerType.changePhoneNumber.rawValue)", "userCert":usercert, "oldPhoneNumber": self?.phoneNoTF.text ?? ""] as [String : Any]
                let paramStr = JSONTools.jsonStringFromDataDic(dic: paramDic)
                navigator.push(NavigatorURLBindPhone + "/" + paramStr)
              }
            
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            
            break
        case .changePhoneNumber?:
             //修改手机号
            _ = self.viewModel?.changeNewPhoneNo(oldPhoneNo:self.oldPhoneNumber ?? "", usercert: self.userCert ?? "").subscribe(onNext: { [weak self](userInfo) in
                 //WDBAccountManager.sharedManger.loginInfo?.userInfo = userInfo
                 let personInfoVC = WDBPersonalInfoViewController()
                 self?.navigationController?.pushViewController(personInfoVC, animated: true)
                 self?.saveData(userInfo: userInfo)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            break
        default:
            break
        }
    }
    
    
    //保存数据
    func saveData(userInfo: WDBUserInfo) {
        
//        if let token = userInfo.accesstoken, let refreshToken = userInfo.refreshtoken {
//            WDBGlobalDataUserDefaults.saveToken(token: token)
//            WDBGlobalDataUserDefaults.saveRefreshToken(refreshToken: refreshToken)
//        }
        
        if let phone = userInfo.phone {
             WDBGlobalDataUserDefaults.saveUserPhone(phone: phone)
        }
        
        if let bindStatus = userInfo.bindStatus {
            WDBGlobalDataUserDefaults.saveBindStatus(bindStatus: bindStatus)
        }
        if let userid = userInfo.userid {
            WDBGlobalDataUserDefaults.saveUserid(userid: userid)
        }
        if let providerUserId = userInfo.provideruserid {
            WDBGlobalDataUserDefaults.saveProviderUserId(providerUserId: providerUserId)
        }
        if let ID = userInfo.ID {
            WDBGlobalDataUserDefaults.saveID(ID: ID)
        }
        if let userId = userInfo.userId {
            WDBGlobalDataUserDefaults.saveSpecialUserId(userId: userId)
        }
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
