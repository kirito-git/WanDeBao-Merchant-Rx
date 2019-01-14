//
//  WDBQualityGoodsAddViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WDBQualityGoodsAddViewController: WDBBaseViewController {

    var viewModel = WDBProductAddViewModel()
    var buttonVaild = false
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var infoTf: UITextView!
    @IBOutlet weak var picBtn: UIButton!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var isQuality:Bool!
    func passValues (isquality:Bool) {
        isQuality = isquality
        self.title = isQuality ? "精品管理" : "新品管理"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    func bindViewModel() {
        
        //绑定view和VM
        _ = self.nameTf.rx.textInput <-> self.viewModel.shopName
        _ = self.infoTf.rx.textInput <-> self.viewModel.shopIntro
        
        self.viewModel.shopPic.asObservable()
        .map{UIImage.init(named: $0)!}
        .bind(to: self.picBtn.rx.backgroundImage())
        .disposed(by: disposeBag)
        
        //绑定按钮点击事件
        self.confirmBtn.rx.tap
        //0.1秒内值多次变化只取最后一次
        .throttle(0.1, scheduler: MainScheduler.instance)
        .withLatestFrom(self.viewModel.confirmObservable)
        .filter({ (vaild) -> Bool in
            if vaild == false {
                self.wraningAlert()
            }
            return vaild
        })
        //请求网络
        .flatMapLatest{_ in
            self.viewModel.addProduct(isQuality: self.isQuality)
        }
        //请求结果
        .subscribe(onNext:{ response in
            let respData:[String:Any] = response as! [String:Any]
            if respData["error_mesg"] == nil {
                self.showAlert(message: "添加成功！",isBack: true)
            }else {
                self.showAlert(message: respData["error_mesg"] as! String,isBack: false)
            }
        }).disposed(by: disposeBag)
//        .observeOn(MainScheduler.instance) // switch to MainScheduler, UI updates
//        .asDriver(onErrorJustReturn: [])
//        .drive(onNext:{ response in
//            let respData:[String:Any] = response as! [String:Any]
//            if respData["error_mesg"] == nil {
//                self.showAlert(message: "添加成功！",isBack: true)
//            }else {
//                self.showAlert(message: respData["error_mesg"] as! String,isBack: false)
//            }
//        })
        
        //上传图片
        _ = picBtn.rx.tap.subscribe(onNext: {
            YBUploadImageManager.manager.showActionSheetInFatherViewController(fatherVC: self) { (image, imageUrl) in
                print(imageUrl)
                DispatchQueue.main.async {
                    self.picBtn.setBackgroundImage(image, for: .normal)
                    self.viewModel.shopPicUrl.value = imageUrl
                }
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func setupViews() {
        self.infoTf.layer.borderWidth = 1
        self.infoTf.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.picBtn.setBackgroundImage(UIImage.init(named: "button_add"), for: .normal)
        self.videoBtn.setBackgroundImage(UIImage.init(named: "button_add"), for: .normal)
        
        self.contentView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        _ = tap.rx.event
            .subscribe(onNext:{ [weak self] _ in
                self?.view.endEditing(true)
            })
        self.contentView.addGestureRecognizer(tap)
    }
    
    func showAlert(message:String, isBack:Bool) {
        navigator.open(NavigatorURLAlert + "/" + "?title=提示&message=\(message)&isBack=\(isBack)",context: ["fromViewController":self])
    }
    
    func wraningAlert() {
         navigator.open(NavigatorURLAlert + "/" + "?title=提示&message=请填写完整的店铺信息")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
