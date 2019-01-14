//
//  CALayer+color.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    var borderUIColor: UIColor? {
        set {
            self.borderColor = newValue?.cgColor
        }
        
        get {
            return  UIColor.init(cgColor: self.borderColor!)
        }
    }
    var shadowUIColor: UIColor? {
        set {
            
            self.shadowColor = newValue?.cgColor
        }
        
        get {
            return  UIColor.init(cgColor: self.shadowColor!)
        }
    }
    
}

