//
//  WDBShopManageViewControllerTests.swift
//  WanDeBao-MerchantTests
//
//  Created by Mr.zhang on 2018/8/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import XCTest
@testable import WanDeBao_Merchant
import RxSwift
import RxCocoa
import Moya
import RxTest

class WDBShopManageViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    //测试用例需注意
    //1.必须以test开头
    //2.无返回值
    //3.测试方法执行的顺序跟测试方法名有关，比如test01()会优先于test02()执行
    
    //测试请求参数是否正确
    func testShopManageRequestParamsReturnNil() {
        let shopVM = WDBShopManageViewModel()
        XCTAssertNotNil(shopVM.shopId.value, "shopid为空！")
    }
    
    //模拟用户输入信息 测试按钮是否可以点击 验证VM逻辑
    func testShopManageConfirmButtonVaildClick() {
        
    }
    
    func testPerformanceExample() {
        //测试代码运行时间
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
