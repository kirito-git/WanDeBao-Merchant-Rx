//
//  WDBManagementView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBManagementView: UIView {
    
    var collectionView:UICollectionView!
    
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
        collectionLayout.itemSize = CGSize(width:(SCREEN_WIDTH-2)/3, height:(SCREEN_WIDTH-2)/3)
        collectionLayout.minimumLineSpacing = 1
        collectionLayout.minimumInteritemSpacing = 1
        collectionLayout.headerReferenceSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_WIDTH/2)
        collectionLayout.footerReferenceSize = CGSize.zero
        
        collectionView = UICollectionView.init(frame: self.frame, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = UIColor.white
        //注册cell
        collectionView.register(WDBManagementCell.self, forCellWithReuseIdentifier: "WDBManagementCell")
        //注册header
        collectionView.register(WDBManagementHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WDBManagementHeader")
        self.addSubview(collectionView)
    }
}
