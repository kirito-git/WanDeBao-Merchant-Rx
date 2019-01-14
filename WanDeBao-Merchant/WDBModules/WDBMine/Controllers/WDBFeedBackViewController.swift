//
//  WDBFeedBackViewController.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/18.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD

class WDBFeedBackViewController: WDBBaseViewController {
    
    lazy var feedbackView = WDBFeedBackView()
    var viewModel: WDBMineViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.title = "意见反馈"
        
//         let insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
//         print(insets)
        feedbackView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.frame.size.height)
         self.view.addSubview(feedbackView)
         bindViewModel()
    }

    func bindViewModel() {
        viewModel = WDBMineViewModel()
        
         _ = feedbackView.inputTextView.rx.text.orEmpty.bind(to: viewModel.content)
        
         _ = feedbackView.submitFeedbackBtn.rx.tap.subscribe(onNext: { [weak self](event) in
            
            if self?.viewModel.content.value == "" {
                YBProgressHUD.showTipMessage(text: "请输入您的反馈意见")
                return
            }
            
           _ = self?.viewModel.suggestionFeedback().subscribe(onNext: { (response) in
            
                YBProgressHUD.showTipMessage(text: "谢谢你的反馈，我们会尽快处理！")
                self?.feedbackView.inputTextView.text = ""
            }, onError: { (error) in
                
            }, onCompleted: nil, onDisposed: nil)
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
