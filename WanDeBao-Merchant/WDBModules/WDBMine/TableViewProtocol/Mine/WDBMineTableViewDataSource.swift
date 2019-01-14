//
//  WDBMineTableViewDataSource.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/15.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBMineTableViewDataSource: NSObject,UITableViewDataSource {
    
    public var dataArray:[WDBMineModel]?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WDBMineCell") as? WDBMineCell
        if let array = dataArray, array.count > 0 {
            cell?.setValueForCell(mineModel: array[indexPath.section])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray!.count
    }
    

}
