//
//  WDBManagementModel.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import RxDataSources

class ManageCellModel {
    var icon: String?
    var title: String?
}


//RxDataSourse自定义section model

struct ManageIndexSection {
    var items: [Item]
}

extension ManageIndexSection: SectionModelType {
    
    typealias Item = ManageCellModel
    
    init(original: ManageIndexSection, items: [Item]) {
        self = original
        self.items = items
    }
}
