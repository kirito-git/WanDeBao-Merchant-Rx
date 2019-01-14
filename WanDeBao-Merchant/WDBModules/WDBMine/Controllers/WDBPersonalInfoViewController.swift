//
//  WDBPersonalInfoViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBPersonalInfoViewController: WDBBaseViewController {
   
    public let kNotificationReloadData = "kNotificationReloadData"
    public typealias WDBChangePersonalInfoClourse = (_ actionType:WDBChangePersonalInfoActionType) -> Void
    public var changePersonalInfoClourse:WDBChangePersonalInfoClourse?
    
    lazy var tableView = UITableView()
    lazy var personalInfoDelegate = WDBPersonalInfoDelegate()
    lazy var personalInfoDataSource = WDBPersonalInfoDataSource()
    lazy var viewModel = WDBMineViewModel()
    var weChatViewModel: WDBWeChatViewModel!
    var notificationCenter: NotificationCenter!
    var observer: NSObjectProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "个人信息"
        tableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        tableView.delegate = personalInfoDelegate
        personalInfoDelegate.changePersonalInfoClourse = changePersonalInfoClourse
        tableView.dataSource = personalInfoDataSource
        tableView.backgroundColor = APP_BK_COLOR
        self.view.addSubview(tableView)
        bindEvent()
        notificationCenter = NotificationCenter.default
        let operationQueue = OperationQueue.main
        observer = notificationCenter.addObserver(
            forName: NSNotification.Name(rawValue: kNotificationReloadData),
            object: nil, queue: operationQueue, using: { [weak self](notification) in
              self?.initTableView()
        })
        // Do any additional setup after loading the view.
    }
    
    func initTableView() {
        self.personalInfoDataSource.dataDic["avatarUrl"] =  WDBGlobalDataUserDefaults.getAvatar()
        self.personalInfoDataSource.dataDic["phoneNo"] = WDBGlobalDataUserDefaults.getUserPhone()
        self.personalInfoDataSource.dataDic["bindStatus"] = WDBGlobalDataUserDefaults.getBindStatus()
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTableView()
    }
    
    func bindEvent() {
        
        //weChatViewModel = WDBWeChatViewModel()

        personalInfoDelegate.changePersonalInfo{ [weak self](actionType) in
            
            if actionType == WDBChangePersonalInfoActionType.changeAvatar {
                
                YBUploadImageManager.manager.showActionSheetInFatherViewController(fatherVC: self!, uploadClourse: { (image, imageUrl) in
                    print(imageUrl)
                    DispatchQueue.main.async {
                     self?.changeAvatar(image: image, imageUrl: imageUrl)
                    }
                })

            }else if actionType == WDBChangePersonalInfoActionType.changePhone {
                //绑定手机
                let paramsDic = ["type":"\(WDBPhoneNoAndCodeControllerType.changePhoneNumber.rawValue)"]
                let jsonStr = JSONTools.jsonStringFromDataDic(dic: paramsDic)
                navigator.push(NavigatorURLBindPhone + "/" + jsonStr)
                
            }else if actionType == WDBChangePersonalInfoActionType.bindWeChat {
               //绑定微信
                
                if !WXApi.isWXAppInstalled() {
                    YBProgressHUD.showTipMessage(text: "请先安装微信")
                    return
                }
               WDBWeChatViewModel.shared.weChatClickWithOperationType(operationType: .bind, viewController: self!)
            }
        }
    }
    
    
    // 改变用户头像
    func changeAvatar(image:UIImage, imageUrl:String) {
        
        personalInfoDataSource.dataDic["avatarUrl"] = imageUrl
        
        self.tableView.reloadData()
        
     _ = viewModel.changeAvatar(avatar: imageUrl).subscribe(onNext: {(dic) in
            print("更换成功response=\(dic["imageurl"] ?? "")")
            let imageUrl = dic["imageurl"] as? String ?? ""
            WDBGlobalDataUserDefaults.saveAvatar(imageUrl: imageUrl)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    //更换手机号码
    func changePhoneNumber() {
        
    }
    
    deinit {
        //销毁时移除通知
        notificationCenter.removeObserver(observer)
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
