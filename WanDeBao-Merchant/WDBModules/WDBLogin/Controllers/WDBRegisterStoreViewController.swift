//
//  WDBRegisterStoreViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//
import UIKit

class WDBRegisterStoreViewController: WDBBaseViewController,UIActionSheetDelegate {
    
    @IBOutlet weak var storeNameTF: UITextField!
    @IBOutlet weak var storePhoneTF: UITextField!
    
    @IBOutlet weak var storeAddressTF: UITextField!
    
    @IBOutlet weak var businessCategoryBtn: UIButton!
    
    @IBOutlet weak var okBtn: UIButton!
    
    private var authenticationInfoDic: [String:Any] = [String:Any]()
    private var businessCategory:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "注册门店"
        self.view.backgroundColor = UIColor.white
        
         bindViewModel()
        //在这里请求更新阿里云信息
        WDBCommonHelper.shared.getOSSInfo()
    }
    
    func bindViewModel() {
        
        
    }
    
    //选择经营品类
    @IBAction func selectSaleCategoryAction(_ sender: UIButton) {
        
        let pickerView = WDBSelectBussinessCategoryView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        pickerView.getPickerData()
        
        pickerView.selectBusinessCategory { (cateName, cateItemName, cateItemId) in
            let cateStr = cateName + "-" + cateItemName
            self.businessCategoryBtn.setTitle(cateStr, for: .normal)
            self.authenticationInfoDic["cateIds"] = String(describing: cateItemId)
        }
        
        UIApplication.shared.keyWindow?.addSubview(pickerView)
    }
    
    // 确认创建
    @IBAction func okAction(_ sender: UIButton) {
        
        //商店名称
        if let storeName = storeNameTF.text {
            authenticationInfoDic["shopName"] = storeName
            if storeName == "" {
                YBProgressHUD.showTipMessage(text: "请输入店铺名称")
                return
            }
        }
        
        //商店地址
        if let storeAddress = storeAddressTF.text {
            authenticationInfoDic["address"] = storeAddress
            if storeAddress == "" {
                YBProgressHUD.showTipMessage(text: "请输入店铺地址")
                return
            }
        }
        
        //联系电话
        if let storePhone = storePhoneTF.text {
            authenticationInfoDic["phone"] = storePhone
            if storePhone == "" {
                YBProgressHUD.showTipMessage(text: "请输入店铺联系电话")
                return
            }
        }
        //经营类别
        authenticationInfoDic["type"] = "0"
        
        let catesId = authenticationInfoDic["cateIds"] as? String
        if catesId == nil {
            YBProgressHUD.showTipMessage(text: "请选择经营品类")
            return
        }
        
        let paramStr = JSONTools.jsonStringFromDataDic(dic: authenticationInfoDic)
        navigator.push(NavigatorURLSubmitInfo + "/" + paramStr)
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


