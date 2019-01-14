//
//  WDBShopManageViewController.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/12.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WDBShopManageViewController: WDBBaseViewController {

    var viewModel:WDBShopManageViewModel!
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var shopNameTf: UITextField!
    @IBOutlet weak var shopPhoneTf: UITextField!
    @IBOutlet weak var cateBorderView: UIView!
    @IBOutlet weak var cateButton: UIButton!
    @IBOutlet weak var cateLab: UILabel!
    @IBOutlet weak var logoBtn: UIButton!
    @IBOutlet weak var shopPicBtn: UIButton!
    @IBOutlet weak var shopIntroTView: UITextView!
    @IBOutlet weak var shopAddressTView: UITextView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "店铺管理"
        setupViews()
        bindViewModel()
    }

    func bindViewModel() {
        
        viewModel = WDBShopManageViewModel()
        
        //双向绑定VM和view
        _ = self.shopNameTf.rx.textInput <-> viewModel.shopName
        _ = self.shopPhoneTf.rx.textInput <-> viewModel.phone
        _ = self.shopIntroTView.rx.textInput <-> viewModel.des
        _ = self.shopAddressTView.rx.textInput <-> viewModel.address
        
        //绑定button图片
        _ = self.viewModel.shopLogoUrl.asObservable().subscribe(onNext:{value in
            self.logoBtn.kf.setBackgroundImage(with: URL.init(string: value), for: UIControlState.normal, placeholder: UIImage.init(named: "button_add"), options: nil, progressBlock: nil, completionHandler: nil)
        })
        
        _ = self.viewModel.shopPicUrl.asObservable().subscribe(onNext:{value in
            self.shopPicBtn.kf.setBackgroundImage(with: URL.init(string: value), for: UIControlState.normal, placeholder: UIImage.init(named: "button_add"), options: nil, progressBlock: nil, completionHandler: nil)
        })
        
        //获取店铺信息
        _ = viewModel.getShopInfo()
        
        //点击确定
       _ = self.confirmBtn.rx.tap
            //0.1秒内多次操作只取最后一次值 0.1秒内只取最后一次操作
            .throttle(0.1, scheduler: MainScheduler.instance)
            //do Next 在subscribe之前调用
            .do(onNext:{ (vaild) in
                //取消键盘响应
                self.view.endEditing(true)
            })
            //合并序列 将confirmObser合并到点击序列中 结果向下传递
            .withLatestFrom( self.viewModel.confirmVaild )
            .filter({  (vaild) -> Bool in
                if vaild == false {
                    //数据错误提示
                    self.wraningAlert()
                }
                return vaild
            })
            //.takeWhile{$0 == true}
            //网络请求
            .flatMapLatest{_ in self.viewModel.changeShopInfo()}
            //请求结果
            .subscribe(onNext:{[weak self](model) in
                print("finish-----------------")
                self?.successAlert()
            }).disposed(by: disposeBag)
        
        
        content.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        _ = tap.rx.event
            .subscribe(onNext:{ [weak self] _ in
                self?.view.endEditing(true)
            })
        content.addGestureRecognizer(tap)

        
        //分类按钮
        _ = self.cateButton.rx.tap.subscribe(onNext: {
            let pickerView = WDBSelectBussinessCategoryView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
            pickerView.getPickerData()
            
            pickerView.selectBusinessCategory { (cateName, cateItemName, cateItemId) in
                let cateStr = cateName + "-" + cateItemName
                self.cateLab.text = cateStr
                self.viewModel.cateIds.value = String(describing:cateItemId)
            }
            
            UIApplication.shared.keyWindow?.addSubview(pickerView)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        //添加logo
        _ = logoBtn.rx.tap.subscribe(onNext: {
            YBUploadImageManager.manager.showActionSheetInFatherViewController(fatherVC: self) { (image, imageUrl) in
                print(imageUrl)
                DispatchQueue.main.async {
                    self.logoBtn.setBackgroundImage(image, for: .normal)
                    self.viewModel.shopLogoUrl.value = imageUrl
                }
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        //添加商铺图片
        _ = shopPicBtn.rx.tap.subscribe(onNext: {
            YBUploadImageManager.manager.showActionSheetInFatherViewController(fatherVC: self) { (image, imageUrl) in
                print(imageUrl)
                DispatchQueue.main.async {
                    self.shopPicBtn.setBackgroundImage(image, for: .normal)
                    self.viewModel.shopPicUrl.value = imageUrl
                }
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    func wraningAlert() {
        navigator.open(NavigatorURLAlert + "?title=提示&message=请填写完整的店铺信息！")
    }
    func successAlert() {
        navigator.open(NavigatorURLAlert + "?title=提示&message=店铺修改成功")
    }

    func setupViews() {
        self.logoBtn.setBackgroundImage(UIImage.init(named: "button_add"), for: .normal)
        self.shopPicBtn.setBackgroundImage(UIImage.init(named: "button_add"), for: .normal)
        self.shopAddressTView.layer.borderWidth = 1
        self.shopAddressTView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.shopIntroTView.layer.borderWidth = 1
        self.shopIntroTView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.cateBorderView.layer.borderWidth = 1
        self.cateBorderView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.cateBorderView.layer.cornerRadius = 5
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


