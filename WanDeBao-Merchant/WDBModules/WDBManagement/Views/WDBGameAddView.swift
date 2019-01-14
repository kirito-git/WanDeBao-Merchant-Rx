//
//  WDBGameAddView.swift
//  WanDeBao-Merchant
//
//  Created by Mr.zhang on 2018/5/14.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class WDBGameAddView: UIView ,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    
    var gameAddTableView:UITableView!
    var tableHeader:UIView!
    var totalChoseLab:UILabel!
    var totalChoseNum:UILabel!
    var confirmButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews() -> Void {
        
        gameAddTableView = UITableView()
        gameAddTableView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH)
        gameAddTableView.backgroundColor = UIColor.groupTableViewBackground
        gameAddTableView.rowHeight = 70
        self.addSubview(gameAddTableView)
        gameAddTableView.register(WDBGameAddCell.self, forCellReuseIdentifier: "WDBGameAddCell")
        gameAddTableView.tableFooterView = UIView()
        gameAddTableView.emptyDataSetSource = self
        gameAddTableView.emptyDataSetDelegate = self
        
        setTableHeaderView()
        
        setBottomView()
    }
    
    func setTableHeaderView() -> Void {
        tableHeader = UIView()
        tableHeader.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:40)
        tableHeader.backgroundColor = UIColor.white
        
        totalChoseLab = UILabel()
        totalChoseLab.text = "已选择游戏"
        totalChoseLab.font = UIFontWithSize(size: 14)
        totalChoseLab.textColor = DetailTextColor
        tableHeader.addSubview(totalChoseLab)
        
        totalChoseNum = UILabel()
        totalChoseNum.text = "0"
        totalChoseNum.font = UIFontWithSize(size: 14)
        totalChoseNum.textColor = UIColor.white
        totalChoseNum.backgroundColor = UIColorRGB_Alpha(R: 46, G: 209, B: 87, alpha: 1)
        totalChoseNum.textAlignment = NSTextAlignment.center
        totalChoseNum.layer.cornerRadius = 12
        totalChoseNum.layer.masksToBounds = true
        tableHeader.addSubview(totalChoseNum)
        
        let line = UIView()
        line.backgroundColor = UIColor.groupTableViewBackground
        tableHeader.addSubview(line)
        
        totalChoseLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(21)
        }
        
        totalChoseNum.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    func setBottomView() -> Void {
        confirmButton = UIButton()
        confirmButton = UIButton()
        confirmButton.frame = CGRect(x:0,y:SCREEN_HEIGHT-kNavibarH-50-iPhoneXBottomBarH,width:SCREEN_WIDTH,height:50)
        confirmButton.setTitle("确 定", for: UIControlState.normal)
        confirmButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        confirmButton.titleLabel?.font = UIFontWithSize(size: 14)
        confirmButton.backgroundColor = UIColor_MainOrangeColor
        self.addSubview(confirmButton)
        
//        _ = confirmButton.rx.tap.subscribe(onNext: {
//
////            self.actionSheet = PGActionSheet(cancelButton: true, buttonList: ["支付宝支付", "微信支付"])
////            self.actionSheet.delegate = self.parentControl
////            self.parentControl.present(self.actionSheet, animated: false, completion: nil)
////            self.actionSheet.actionSheetTranslucent = false
////            self.actionSheet.textFont = UIFontWithSize(size: 14)
////            self.actionSheet.textColor = TitleTextColor
////            self.actionSheet.cancelTextFont = UIFontWithSize(size: 14)
//            
//
//        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WDBGameAddCell", for: indexPath) as! WDBGameAddCell
        let model = viewModel.gameList[indexPath.row]
        cell.imageVi.kf.setImage(with: URL.init(string: model.productImgUrl ?? ""), placeholder: UIImage.init(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
        cell.gameNameLab.text = model.name ?? ""
        cell.gameInfoLab.text = model.timesTypeName ?? ""
        cell.selectButton.isSelected = viewModel.markArray[indexPath.row]
        cell.priceLab.text = "¥\(String(describing: model.price ?? 0))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.markArray[indexPath.row] = !self.viewModel.markArray[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! WDBGameAddCell
        cell.selectButton.isSelected = !cell.selectButton.isSelected
        
        totalChoseNum.text = self.viewModel.getNum()
    }
    */
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "暂无游戏", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
    }
}

