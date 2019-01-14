//
//  RequestPlugin.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/21.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import Result
import SVProgressHUD
import SwiftyJSON


public final class RequestLoadingPlugin: PluginType {
    
    /// 展示或隐藏加载hud
    public func willSend(_ request: RequestType, target: TargetType) {
        //show loading
         SVProgressHUD.show()
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
         //hide  loading
         SVProgressHUD.dismiss()
    }
    
}


// MARK: - AccessTokenAuthorizable
/// A protocol for controlling the behavior of `AccessTokenPlugin`.
  public protocol AccessTokenAuthorizable {
    
    /// Represents the authorization header to use for requests.
   var authorizationType: AuthorizationType {
        get
    }
}

// MARK: - AuthorizationType
/// An enum representing the header to use with an `AccessTokenPlugin`
public enum AuthorizationType: String {
    /// No header.
    case none
    
    /// The `"Basic"` header.
    case basic = "Basic"
    
    /// The `"Bearer"` header.
    case bearer = "Bearer"
}

//检验Token 的合法性
internal final class AccessTokenPlugin: PluginType {
    
    public let tokenClosure: () -> String
    
    public init(tokenClosure: @escaping @autoclosure () -> String) {
        self.tokenClosure = tokenClosure
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        guard let authorizable = target as? AccessTokenAuthorizable else { return request }
        
        let authorizationType = authorizable.authorizationType
        var request = request
        
      switch authorizationType {
        case .bearer:
            let authValue = authorizationType.rawValue + " " + tokenClosure()
            request.setValue(authValue, forHTTPHeaderField: "Authorization")
        case .basic:
            let authValue = authorizationType.rawValue + " " + "eXVuYmFvOnl1bmJhb3NlY3JldA=="
            request.setValue(authValue, forHTTPHeaderField: "Authorization")
            break
        case .none:
            let authValue = "application/json"
            request.setValue(authValue, forHTTPHeaderField: "Content-Type")
            break
        }
        return request
    }

    func willSendRequest(request: RequestType, target: TargetType) {
        
    }
    
    func didReceiveResponse(result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            do {
                let jsonObject = try response.mapJSON()
                let json = JSON(jsonObject)
                if json["status"].intValue == 0 {
               //NSNotificationCenter.defaultCenter().postNotificationName("InvalidTokenNotification", object: nil)
                //在这里发送做刷新token的操作
                    
                }
            } catch {
                
            }
        case .failure(_):
            break
        }
    }
    
//    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
//
//    }
    
    
}

// 网络logger
public final class NetworkLogger: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
        
    }
    
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
         //隐藏提示框
        
//        #if DEBUG
            switch result {
            case .success(let response):
                //状态码为200（请求成功）、401（请求未授权）、404（服务器报错）、500（服务器内部错误）
                print("\(response.request!)")
//                 let json = JSON.init(response.data)
//                 print("jsonerror\(json)")
                
                //此处状态码为200可以此打印出返回信息
                if response.statusCode == 200 {
                    let json = JSON.init(response.data)
                    
                    //print("成功reponse = \(json)")
                    SVProgressHUD.dismiss()
                }else{
                     parseError(response: response)
                    let json = JSON.init(response.data)
                    print("jsonError = \(json)")
                }
            case .failure(let error):
           //这里的失败指的是服务器没有收到请求（例如可达性／连接性错误）或者没有发送请求（例如请求延时）。可以再次设置延时，重新发送请求
                 print("请求失败的原因：\(error.errorDescription ?? "")")
                 if let errorStr = error.errorDescription {
                  //SVProgressHUD.showError(withStatus: "服务器连接失败")
                    YBProgressHUD.showTipMessage(text: "服务器连接失败")
                }
          }
        //#endif
          }

           // 解析错误
           fileprivate func parseError(response: Response) {
            //解析错误
            //状态码为500的错误 可根据自己的服务器后台返回的数据自由设置，不通用
            if response.statusCode == 500 {
              
                //第一种500错误
//                if let errorMsgStr = JSON.init(response.data)["exception"].string, errorMsgStr == "com.netflix.zuul.exception.ZuulException" {
//                     let error = JSON.init(response.data)["error"].string ?? ""
//                     print(error)
//                     SVProgressHUD.showError(withStatus: error)
//                     return
//                }
                //第二种500错误
                
                if let errorMsgStr = JSON.init(response.data)["message"].string {
                    let errorMsgArr = errorMsgStr.components(separatedBy: "\n")
                    let errorMsgs = errorMsgArr.first ?? ""
                    if let errorMsg = errorMsgs.components(separatedBy: ":").last, errorMsg.count > 0 {
                        //SVProgressHUD.showError(withStatus: errorMsg)
                        YBProgressHUD.showTipMessage(text: errorMsg)
                    }
                    return
                }
                //第三种500错误
//                if let errMsgStr = JSON.init(response.data)["error_msg"].string {
//                     print(errMsgStr)
//                     SVProgressHUD.showError(withStatus: errMsgStr)
//                     return
//                }
                 // 如果两者都不是就提示服务器内部错误，此处可自定义
                  //SVProgressHUD.showError(withStatus: "服务器内部错误")
                   YBProgressHUD.showTipMessage(text: "服务器内部错误")
                
            }
            //状态码为417的错误
            if response.statusCode == 417 {
                
                if let errorMsg = JSON.init(response.data)["error_mesg"].string {
                    //print("状态码为:\(response.statusCode)\(json)")
                    //SVProgressHUD.showError(withStatus: errorMsg)
                    YBProgressHUD.showTipMessage(text: errorMsg)
            }
            // 状态码是401提示刷新Token
                if response.statusCode == 401 {
                    //SVProgressHUD.showError(withStatus: "服务器内部错误")
                    // 发送刷新Token的通知
                    //NotificationCenter.default.post(name: NSNotification.Name(rawValue: kRefreshTokenNotification), object: nil)
                }
        
         }
    
    }

}
