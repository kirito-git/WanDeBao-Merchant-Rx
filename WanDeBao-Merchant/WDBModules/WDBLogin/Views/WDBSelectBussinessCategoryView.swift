//
//  WDBSelectBussinessCategoryView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/7/12.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Moya
import RxSwift

typealias WDBSelectBusinessCategoryClourse = (_ cateName: String, _ cateItemName:String, _ cateItemId:Int) -> Void

class WDBSelectBussinessCategoryView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selectBusinessCategoryClourse: WDBSelectBusinessCategoryClourse?
    var bgMaskView: UIView!
    var pickerView: UIPickerView!
    var pickerBackView: UIView!
    var cateListArray: [WDBShopBusinessCategoryModel] = [WDBShopBusinessCategoryModel]()
    var cateListItemArray: [WDBShopBusinessCategoryModel] = [WDBShopBusinessCategoryModel]()
    var selectCateListArray: [WDBShopBusinessCategoryModel] = [WDBShopBusinessCategoryModel]()
    var viewModel: WDBRegisterStoreViewModel?
    var cateName: String?
    var cateItemName: String?
    var cateItemId: Int?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func selectBusinessCategory(clourse: @escaping WDBSelectBusinessCategoryClourse) {
         self.selectBusinessCategoryClourse = clourse
    }
    
    
    func show() {
        
        viewModel = WDBRegisterStoreViewModel()
        //获取数据
        //初始化数据
        initView()
    }
    
    func initView() {
         bgMaskView = UIView.init(frame: UIScreen.main.bounds)
         bgMaskView.backgroundColor = UIColor.black
         bgMaskView.alpha = 0
        
          // 添加手势
         let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(hidePicker))
         bgMaskView.addGestureRecognizer(tapGes)
        
         pickerBackView = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height - (180+30), width: self.width, height: 180+30))
         pickerBackView.backgroundColor = UIColor.white
        
         let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: 36))
         bgView.backgroundColor = UIColorRGB_Alpha(R: 222, G: 222, B: 222, alpha: 1)
         pickerBackView.addSubview(bgView)
        
         //取消按钮
         let cancelBtn = UIButton.init(type: .custom)
         cancelBtn.frame = CGRect.init(x: 0, y: 3, width: 50, height: 30)
         cancelBtn.setTitle("取消", for: .normal)
         cancelBtn.setTitleColor(UIColor.black, for: .normal)
         cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
         cancelBtn.titleLabel?.adjustsFontSizeToFitWidth = true
         cancelBtn.setTitleColor(UIColor_MainOrangeColor, for: .normal)
         cancelBtn.addTarget(self, action: #selector(cancelChoose), for: .touchUpInside)
         bgView.addSubview(cancelBtn)
        
         //确认按钮
         let ensureBtn = UIButton.init(type: .custom)
         ensureBtn.frame = CGRect.init(x: pickerBackView.width - 50, y: 3, width: 50, height: 30)
         ensureBtn.setTitleColor(UIColor.black, for: .normal)
         ensureBtn.setTitle("确定", for: .normal)
         ensureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
         ensureBtn.titleLabel?.adjustsFontSizeToFitWidth = true
         ensureBtn.setTitleColor(UIColor_MainOrangeColor, for: .normal)
         ensureBtn.addTarget(self, action: #selector(ensureChoose), for: .touchUpInside)
         bgView.addSubview(ensureBtn)
        
         pickerView = UIPickerView.init(frame: CGRect.init(x: 0, y: (pickerBackView.frame.size.height - 160)/2, width: self.width, height: 160))
         pickerView.delegate = self
         pickerView.dataSource = self
         pickerBackView.addSubview(pickerView)
        
        
        showPicker()
        
    }
    
    //MARK - 获取数据
    func getPickerData() {
        
        _ = viewModel?.getPickerData().subscribe(onNext: { (modelArray) in
            
          self.configureDataArray(modelArray: modelArray)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    
    }
    
    func configureDataArray(modelArray:[WDBShopBusinessCategoryModel]) {
         self.cateListArray = modelArray
        
         if self.cateListArray.count > 0 {
            self.cateListItemArray  = [WDBShopBusinessCategoryModel]()
            self.cateListItemArray = self.cateListArray[0].cateList!
            
            self.cateName = self.cateListArray[0].cateName ?? ""
            self.cateItemName = self.cateListItemArray[0].cateName ?? ""
            self.cateItemId = self.cateListItemArray[0].Id ?? -1
        }
        
        self.pickerView.reloadAllComponents()
    }
    
    //MARK - UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.cateListArray.count
        }else{
            return self.cateListItemArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            //print("标题\(String(describing: self.cateListArray[row].cateName))")
            self.cateName = self.cateListArray[row].cateName ?? ""
           return self.cateListArray[row].cateName
        }else {
          let selectedRow = pickerView.selectedRow(inComponent: 0)
             let arr = self.cateListArray[selectedRow].cateList
            //print("内部\(String(describing: arr?[row].cateName))")
            self.cateItemName = arr?[row].cateName
            self.cateItemId = arr?[row].Id
            return arr?[row].cateName
        }
    }
   
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init()
        let height:CGFloat = 30
        
        if view == nil {
            label.frame = CGRect.init(x: 0, y: 0, width: floor(pickerView.width/3), height: height)
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: 20)
        }
        label.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.cateListArray.count > 0 && component == 0{
            self.cateListItemArray = [WDBShopBusinessCategoryModel]()
            self.cateListItemArray = self.cateListArray[row].cateList!
        }
        
        switch component {
        case 0:
            //拖动第0列时，要及时刷新第1列
           pickerView.reloadComponent(1)
           pickerView.selectRow(0, inComponent: 1, animated: true)
         break
        default:
        break
        }
    }
    
    //MARK - Action
    func showPicker() {
      self.addSubview(bgMaskView)
      self.addSubview(pickerBackView)
      self.bgMaskView.alpha = 0
      pickerBackView.y = self.height
        
        UIView.animate(withDuration: 0.3) {
            self.bgMaskView.alpha = 0.3
            self.pickerBackView.y = 0
            self.pickerBackView.y = self.height - self.pickerBackView.height
        }
        
    }
    
    
    //取消选择
    @objc func cancelChoose() {
        hidePicker()
    }
    
    //确认选择
   @objc func ensureChoose() {
    if let clourse = self.selectBusinessCategoryClourse {
        clourse(self.cateName ?? "", self.cateItemName ?? "", self.cateItemId ?? -1)
     }
     hidePicker()
   }
    
    //隐藏选项框
    @objc func hidePicker() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bgMaskView.alpha = 0
            self.pickerBackView.y = self.height
        }) { (finished: Bool) in
            self.bgMaskView.removeFromSuperview()
            self.pickerBackView.removeFromSuperview()
            self.removeFromSuperview()
        }
        
    }
    

}
