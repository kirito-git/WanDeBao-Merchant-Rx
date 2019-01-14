//
//  YBCountDownButton.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/24.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class YBCountDownButton: UIButton {

    fileprivate var timer:Timer?
    var maxCount:Int = 60
    var idleTitle:String = "获取验证码"
    fileprivate var downCount:Int = 0
    
    var currentCount:Int {
        get {
            return downCount
        }
    }
    var isCouting = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.uiconfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.uiconfig()
    }
    
    func uiconfig() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.setTitle(idleTitle, for: .normal)
        self.setTitle(idleTitle, for: .disabled)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    func start() {
        downCount = maxCount
        reset()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
        timer?.fireDate = Date()
        isCouting = true
    }
    
    func reset() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
        self.setTitle(idleTitle, for: .normal)
        self.setTitle(idleTitle, for: .disabled)
        self.titleLabel?.textColor = UIColor.white
        self.isEnabled = true
        isCouting = false
    }
    
    @objc fileprivate func countDownAction() {
        downCount -= 1
        if downCount <= 0 {
            downCount = 0
            reset()
        } else {
            self.isEnabled = false
            self.setTitle("\(downCount)s后重试", for: .disabled)
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            self.reset()
        }
    }
    
    
    
    
    
}
