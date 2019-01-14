//
//  WDBRechargeViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class WDBRechargeViewController: WDBBaseViewController, OrderPayFinishDelegate ,LLPaySdkDelegate{
 

    @IBOutlet weak var rechargeView: UIView!
    @IBOutlet weak var inputLabel: UITextField!
    @IBOutlet weak var selectWeChatImgView: UIImageView!
    @IBOutlet weak var selectAliPayImgView: UIImageView!
    @IBOutlet weak var selectLLPayImgView: UIImageView!
    @IBOutlet weak var weChatView: UIView!
    @IBOutlet weak var aliPayView: UIView!
    @IBOutlet weak var LLPayView: UIView!
    @IBOutlet weak var choseBankView: UIView!
    @IBOutlet weak var bankCardLab: UILabel!
    @IBOutlet weak var payTypeTipLab: UIView!
    @IBOutlet weak var ensureRechargeBtn: UIButton!
    
    var payType: WDBPayType?
    var payChannel: WDBPayChannel?
    var bankVCCallBack_BankCardId: String?
    
    var mineViewModel: WDBMineViewModel?
    var payViewModel: WDBPayViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "充值"
        bindEvent()
        hideChoseBankView(isHide: true)
    }

    func bindEvent() {
        
        mineViewModel = WDBMineViewModel()
        payViewModel = WDBPayViewModel()
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        myAppDelegate.orderPayDelegate = self
        self.payType = WDBPayType.wxpay
        self.payChannel = WDBPayChannel.wxpay
        
        self.ensureRechargeBtn.layer.cornerRadius = 5;
        self.ensureRechargeBtn.layer.masksToBounds = true
        
        //微信支付点击
        let weChatTapGesture = UITapGestureRecognizer()
        weChatView.addGestureRecognizer(weChatTapGesture)
        
        weChatTapGesture.rx.event.bind { [weak self](recognizer) in
            self?.savePayType(payType: .wxpay)
            self?.selectWeChatImgView.image = UIImage.init(named: "mine_radius_select")
            self?.selectAliPayImgView.image = UIImage.init(named: "mine_radius_unselect")
            self?.selectLLPayImgView.image = UIImage.init(named: "mine_radius_unselect")
            print("1")
            self?.hideChoseBankView(isHide: true)
            }.disposed(by: disposeBag)
        
        //支付宝支付点击
        let aliPayTapGesture = UITapGestureRecognizer()
        aliPayView.addGestureRecognizer(aliPayTapGesture)
        
        aliPayTapGesture.rx.event.bind { [weak self](recognizer) in
            self?.savePayType(payType: .alipay)
            self?.selectWeChatImgView.image = UIImage.init(named: "mine_radius_unselect")
            self?.selectAliPayImgView.image = UIImage.init(named: "mine_radius_select")
            self?.selectLLPayImgView.image = UIImage.init(named: "mine_radius_unselect")
            print("2")
            self?.hideChoseBankView(isHide: true)
        }.disposed(by: disposeBag)

        
        //连连支付点击
        let llpayTapGesture = UITapGestureRecognizer()
        LLPayView.addGestureRecognizer(llpayTapGesture)
        
        llpayTapGesture.rx.event.bind { [weak self](recognizer) in
            self?.savePayType(payType: .llpay)
            self?.selectWeChatImgView.image = UIImage.init(named: "mine_radius_unselect")
            self?.selectAliPayImgView.image = UIImage.init(named: "mine_radius_unselect")
            self?.selectLLPayImgView.image = UIImage.init(named: "mine_radius_select")
            print("3")
            self?.hideChoseBankView(isHide: false)
        }.disposed(by: disposeBag)
        
    }
    
    
    
    @IBAction func choseBankAction(_ sender: UIButton) {
        let params = ["isSelect":"1"]
        //let jsonStr = JSONTools.jsonStringFromDataDic(dic: params)
        //navigator.push(NavigatorURLBindBankCard + "/" + jsonStr)
        if let bankCardVC = navigator.viewController(for: NavigatorURLMyBankCard) as? WDBMyBankCardViewController {
            bankCardVC.passValueClourse({ (bankCardId, bankCard) in
                print(bankCard)
                self.bankCardLab.text = bankCard
                self.bankVCCallBack_BankCardId = bankCard
            })
//            bankCardVC.rechargeVCBlock = { (bankCardId, bankCard) in
//                print(bankCard ?? "")
//            }
        }
        navigator.push(NavigatorURLMyBankCard,context:params)
    }
    
// 确认充值
  @IBAction func ensureRechargeAction(_ sender: UIButton) {
    
    let model = createModel()
    if let price = model.shopPrice, price == 0 {
        YBProgressHUD.showTipMessage(text: "请输入金额")
        return
    }
    if self.payType == WDBPayType.llpay {
        //连连
        var params = [String:Any]()
        params["shopId"] = WDBGlobalDataUserDefaults.getShopID()
        params["money"] = model.shopPrice ?? 0
        //测试 ***************************
        params["bankId"] = "47"
        //测试 ***************************
        
        let orderPrice = model.shopPrice ?? 0
        _ = mineViewModel?.llpayRecharge(params: params).subscribe(onNext: { (model) in
            print(model.Id)
            let model = model
            //调用连连支付SDK
            self.payViewModel?.callLLPaySDK(model: model, price: Float(orderPrice), viewcontroller: self)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }else {
        //微信或支付宝
        _ = mineViewModel?.productAddOrder(orderUnionType: 9, selectProductModel: model).subscribe(onNext: { [weak self](orderModel) in
            
            //支付
            let orderPayId = String(describing: orderModel.orderPay?.id ?? 0)
            let payType = self?.payType?.rawValue ?? ""
            let payChannel = self?.payChannel?.rawValue ?? ""
            
            self?.payViewModel?.startOrderPayWith(orderPayId:orderPayId, payType: WDBPayType(rawValue: payType)!, payChannel: payChannel, mchId: "100001")
            
            
            }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
 }
    
    //创建一个自定义Model
    func createModel() -> WDBProductModel {
        let shopId = Int(WDBGlobalDataUserDefaults.getShopID()) ?? 0

        let inputContent = self.inputLabel.text ?? ""
        let showPrice = Double(inputContent) ?? 0.0
        let paramDic = ["shopId":shopId, "shopPrice":showPrice, "productId":0, "name":"线上支付", "sellPrice":showPrice, "point":0, "cateId":0, "productIcoUrl":"", "price":showPrice] as [String : Any]
        let model = WDBCommonHelper.shared.changeDictionaryToModel(type: WDBProductModel.self, dict: paramDic)
        return model
    }

    
    func savePayType(payType: WDBPayType) {
        
        self.payType = payType
        if payType == WDBPayType.wxpay {
            self.payChannel = WDBPayChannel.wxpay
        }else if payType == WDBPayType.alipay {
            self.payChannel = WDBPayChannel.aliPay
        }
    }
    
    
    // MARK - OrderPayFinishDelegate
    func orderPayFinish(With payType: WDBPayType, isSuccess: Bool, respMsg: String) {
        
        let tips = respMsg
        let alertVC = UIAlertController.init(title: "提示", message: tips, preferredStyle: UIAlertControllerStyle.alert)
        alertVC.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // ------ LLPaySDK Delegate -------
    func paymentEnd(_ resultCode: LLPayResult, withResultDic dic: [AnyHashable : Any]!) {
        print(LLPayUtil.jsonString(ofObj: dic))
        switch resultCode {
        case kLLPayResultSuccess:
            //支付成功
            self.showSuccessAlert()
            break
        case kLLPayResultFail:
            YBProgressHUD.showTipMessage(text: "支付失败")
            break
        case kLLPayResultCancel:
            YBProgressHUD.showTipMessage(text: "取消支付！")
            break
        case kLLPayResultInitError:
            print("初始化异常")
            break
        case kLLPayResultInitParamError:
            print(dic["ret_msg"] ?? "")
            break
        default:
            break
        }
    }
  
    
    func hideChoseBankView(isHide:Bool) {
        let topSpace = isHide==true ? 1 : 47
        UIView.animate(withDuration: 0.3, animations: {
            self.payTypeTipLab.snp.updateConstraints({ (make) in
                make.top.equalTo(self.rechargeView.snp.bottom).offset(topSpace)
            })
            //动态更新约束
            self.view.layoutIfNeeded()
        }) { (finish) in
           self.choseBankView.isHidden = isHide
        }
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController.init(title: "提示", message: "充值成功！", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
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
