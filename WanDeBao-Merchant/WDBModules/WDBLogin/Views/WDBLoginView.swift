//
//  WDBLoginView.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/8.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

class WDBLoginView: UIView {
    
    lazy var appIconImgView = UIImageView()
    lazy var phoneNoBgView = UIImageView()
    var phoneNoTextField: UITextField!
    lazy var vCodeBgView = UIImageView()
    lazy var vCodeTextField = UITextField()
    lazy var getCodeBtn = YBCountDownButton()
    
    lazy var loginBtn = UIButton()

    lazy var agreeUserProtocolBtn = UIButton()
    lazy var showUserProtocolBtn = UIButton()
    lazy var tipUserProtocolLabel = UILabel()
    
    lazy var separatorLineImgView = UIImageView()
    
    lazy var weChatLoginBtn = UIButton()
    
    public let kEdgeOffset = 35;
    public let kItemHeight = 45;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubview();
        self.backgroundColor = UIColor.white;
    }
    
    private func setupSubview() {
    
        appIconImgView.image = UIImage.init(named: "login_logo")
        self.addSubview(appIconImgView)
        
        phoneNoBgView.image = UIImage.init(named: "login_inputbg")
        self.addSubview(phoneNoBgView);
        
        phoneNoTextField = UITextField()
        phoneNoTextField.placeholder = "请输入手机号";
        phoneNoTextField.keyboardType = .phonePad
        phoneNoTextField.font = UIFont.systemFont(ofSize: 15)
        phoneNoTextField.clearButtonMode = .whileEditing
        self.addSubview(phoneNoTextField);
        
        //验证码
        vCodeBgView.image = UIImage.init(named: "login_inputbg")
        self.addSubview(vCodeBgView);
        
        vCodeTextField.placeholder = "请输入验证码";
        vCodeTextField.keyboardType = .namePhonePad
        vCodeTextField.clearButtonMode = .whileEditing
        vCodeTextField.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(vCodeTextField);
        
        //获取验证码
        getCodeBtn.setTitle("获取验证码", for: UIControlState.normal)
        getCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        getCodeBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        getCodeBtn.setBackgroundImage(UIImage.init(named: "login_smallbtn_bg"), for: UIControlState.normal)
        self.addSubview(getCodeBtn);
        
        //登录
        loginBtn.setTitle("立即登录", for: UIControlState.normal)
        loginBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginBtn.setBackgroundImage(UIImage.init(named: "login_loginbtn_bg"), for: UIControlState.normal)
        self.addSubview(loginBtn)
        
        //用户协议
        agreeUserProtocolBtn.setImage(UIImage.init(named: "login_checkbox_normal"), for: UIControlState.normal)
        agreeUserProtocolBtn.setImage(UIImage.init(named: "login_checkbox_select"), for: UIControlState.selected)
        agreeUserProtocolBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        agreeUserProtocolBtn.addTarget(self, action: #selector(agreeProtocol), for: UIControlEvents.touchUpInside)
        agreeUserProtocolBtn.isSelected = true
        self.addSubview(agreeUserProtocolBtn)

        tipUserProtocolLabel.text = "我已认真阅读并同意"
        tipUserProtocolLabel.font = UIFont.systemFont(ofSize: 12)
        tipUserProtocolLabel.textColor = UIColor.black
        self.addSubview(tipUserProtocolLabel)

        let str = NSMutableAttributedString(string: "用户协议")
        let strRange = NSRange.init(location: 0, length: str.length)
        let number = NSNumber(integerLiteral: NSUnderlineStyle.styleSingle.rawValue)
        str.addAttributes([NSAttributedStringKey.underlineStyle: number,
                           NSAttributedStringKey.foregroundColor: UIColor.black,
                           NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], range: strRange)
        showUserProtocolBtn.setAttributedTitle(str, for: UIControlState.normal)
        self.addSubview(showUserProtocolBtn)
        
        separatorLineImgView.image = UIImage.init(named: "login_or")
        self.addSubview(separatorLineImgView)
        
        weChatLoginBtn.setTitle("微信账号登录", for: .normal)
        weChatLoginBtn.setTitleColor(UIColor.black, for: .normal)
        weChatLoginBtn.setBackgroundImage(UIImage.init(named: "login_verifyloginbtn"), for: .normal)
        self.addSubview(weChatLoginBtn)
        
        self.setupSubviewsFrame();
    }
    
    private func setupSubviewsFrame() {
        
        appIconImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(kNavibarH*SizeScale)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        phoneNoBgView.snp.makeConstraints { (make) in
            make.top.equalTo(appIconImgView.snp.bottom).offset(35*SizeScale)
            make.left.equalToSuperview().offset(kEdgeOffset)
            make.right.equalToSuperview().offset(-kEdgeOffset)
            make.height.equalTo(kItemHeight)
        }

        phoneNoTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneNoBgView.snp.top)
            make.left.equalTo(phoneNoBgView.snp.left).offset(10)
            make.right.equalTo(phoneNoBgView.snp.right).offset(-10)
            make.height.equalTo(kItemHeight)
        }

        vCodeBgView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneNoBgView.snp.bottom).offset(20*SizeScale)
            make.left.equalTo(kEdgeOffset)
            make.right.equalTo(-kEdgeOffset)
            make.height.equalTo(kItemHeight)
        }

        vCodeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(vCodeBgView.snp.left).offset(10)
            make.right.equalTo(vCodeBgView.snp.right).offset(-100)
            make.top.equalTo(vCodeBgView.snp.top)
            make.bottom.equalTo(vCodeBgView.snp.bottom)
        }
        
        getCodeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(vCodeBgView.snp.right).offset(-10)
            make.top.equalTo(vCodeBgView.snp.top).offset(12*SizeScale)
            make.bottom.equalTo(vCodeBgView.snp.bottom).offset(-12)
            make.width.equalTo(80)
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.right.equalTo(-kEdgeOffset)
            make.top.equalTo(vCodeBgView.snp.bottom).offset(40*SizeScale)
        }
        
        showUserProtocolBtn.snp.makeConstraints { (make) in
            make.top.equalTo(vCodeBgView.snp.bottom).offset(95*SizeScale)
            make.centerX.equalTo(self).offset(50)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
        
        tipUserProtocolLabel.snp.makeConstraints { (make) in
            make.right.equalTo(showUserProtocolBtn.snp.left)
            make.top.equalTo(showUserProtocolBtn)
            make.width.equalTo(115)
            make.height.equalTo(40)
        }
        
        agreeUserProtocolBtn.snp.makeConstraints { (make) in
           make.right.equalTo(tipUserProtocolLabel.snp.left)
           make.top.equalTo(showUserProtocolBtn)
           make.width.equalTo(40)
           make.height.equalTo(40)
        }
        
        separatorLineImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(agreeUserProtocolBtn.snp.bottom).offset(40*SizeScale)
        }
        
        weChatLoginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kEdgeOffset)
            make.right.equalTo(-kEdgeOffset)
            make.top.equalTo(agreeUserProtocolBtn.snp.bottom).offset(70*SizeScale)
        }
        
        
    }
    
    @objc func agreeProtocol() {
        agreeUserProtocolBtn.isSelected = !agreeUserProtocolBtn.isSelected
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.endEditing(true)
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
    }
    
    
    

}
