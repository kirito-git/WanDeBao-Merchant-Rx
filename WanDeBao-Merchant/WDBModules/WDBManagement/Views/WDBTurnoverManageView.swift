//
//  WDBTurnoverManageView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/16.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBTurnoverManageView: UIView {

    var collectionView:UICollectionView!
    var bottomView:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        
        self.backgroundColor = UIColor.white
        
        //设置layout
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width:SCREEN_WIDTH/2-2, height:SCREEN_WIDTH/2)
        collectionLayout.minimumLineSpacing = 1
        collectionLayout.minimumInteritemSpacing = 1
        collectionLayout.headerReferenceSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_WIDTH/2)
        collectionLayout.footerReferenceSize = CGSize.zero
        
        collectionView = UICollectionView.init(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-iPhoneXBottomBarH-50-kNavibarH), collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = UIColor.white
        //注册cell
        collectionView.register(WDBTurnoverManageCell.self, forCellWithReuseIdentifier: "WDBTurnoverManageCell")
        collectionView.register(WDBTurnoverManageAddCell.self, forCellWithReuseIdentifier: "WDBTurnoverManageAddCell")
        //注册header
        collectionView.register(WDBTurnoverManageHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WDBTurnoverManageHeader")
        self.addSubview(collectionView)
        
        setBottomView()
    }
    
    func setBottomView() -> Void {
        
        bottomView = UIButton()
        bottomView = UIButton()
        bottomView.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        bottomView.setTitle("设 置", for: UIControlState.normal)
        bottomView.setTitleColor(UIColor.black, for: UIControlState.normal)
        bottomView.titleLabel?.font = UIFontWithSize(size: 14)
        bottomView.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(bottomView)
    }
    

//
//    //cellforitem
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        if indexPath.row == viewModel.tables.count {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WDBTurnoverManageAddCell", for: indexPath) as! WDBTurnoverManageAddCell
//            return cell
//        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WDBTurnoverManageCell", for: indexPath) as! WDBTurnoverManageCell
//        let model = viewModel.tables[indexPath.item]
//        cell.tableNumLab.text = model.tableNum
//        //已上菜 未上菜
//        cell.startStatusBtn.isSelected = model.servingStatus == 1 ? true : false
//        cell.startStatusBtn.backgroundColor = model.servingStatus == 2 ? UIColor.white : UIColor_MainOrangeColor
//        //就餐开始 就餐结束
//        cell.endBtn.isSelected = model.servingStatus == 1 ? true : false
//        cell.endBtn.backgroundColor = model.servingStatus == 2 ? UIColor.white : UIColor_MainOrangeColor
//
//
//        cell.endBtn.tag = indexPath.item
//        cell.endBtn.addTarget(self, action: #selector(startOrEndTakeFood(_:)), for: UIControlEvents.touchUpInside)
//
//        return cell
//    }
//
//
//    //collectionviewHeader
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        var reuseview:WDBTurnoverManageHeader!
//        if kind == UICollectionElementKindSectionHeader {
//            reuseview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WDBTurnoverManageHeader", for:indexPath) as! WDBTurnoverManageHeader
//            if self.model != nil {
//                reuseview.model = self.model
//            }
//        }
//        return reuseview
//    }
//
//    @objc func startOrEndTakeFood (_ button:UIButton) {
//        print(button.tag)
//        parentControl.startOrEndTakeFoodRequest(item: button.tag)
//    }
    
}
