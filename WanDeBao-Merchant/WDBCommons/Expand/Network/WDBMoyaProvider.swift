//
//  WDBMoyaProvider.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/6/1.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import RxSwift
import SwiftyJSON

//多Target共用一个Provider Target->EndPoint->Request

public let defaultProvider = MoyaProvider<MultiTarget>(manager:defaultAlamofireManager(), plugins: [RequestLoadingPlugin(),NetworkLogger(),authPlugin])
//public let defaultProvider = MyMoyaProvider<MultiTarget>(plugins: [RequestLoadingPlugin(),NetworkLogger(),authPlugin])
    //MARK: - 设置请求头部信息

public let customEndPointClosure = {(target: TargetType) -> Endpoint in

        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endpoint = Endpoint(
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
      let accessToken = WDBGlobalDataUserDefaults.getToken()
      if accessToken != "" && target.method == .post {
//        //在这里设置你的HTTP头部信息（服务器生成的token，用户唯一标识）
        //target.headers["Authorization"] = "Bearer" + " " + accessToken
        return endpoint.adding(newHTTPHeaderFields: [
            "Authorization": "Bearer" + " " + accessToken
            ])
      }else{
        return endpoint.adding(newHTTPHeaderFields: [
            "Authorization": "Basic dGVzdDp0ZXN0"
            ])
    }
}
   // 设置Token验证 插件
   let tokenClosure: () -> String = {
     return WDBGlobalDataUserDefaults.getToken()
   }

   let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure())


extension MultiTarget: AccessTokenAuthorizable {
    public var authorizationType: AuthorizationType {
        if ((self.target as? AccessTokenAuthorizable) != nil) {
            return .bearer
        }else{
            return .basic
        }
    }
 }

    //创建HTTPS请求的认证Manager
    //转换证书格式的命令：openssl x509 -outform der -in 证书名.pem -out wandebao-https.cer
    /*
     * 1.客户端用本地保存的根证书解开证书链，确认服务端下发的证书是由可信任的机构颁发的
     * 2.客户端需要检查证书的 domain 域和扩展域，看是否包含本次请求的 host
     */
 public func defaultAlamofireManager() -> Manager {
    let path = Bundle.main.path(forResource: "wandebao-https.cer", ofType: nil) //本地自签名证书文件位置
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 15 //自定义超时时间
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    
    let certificates: [SecCertificate] = [create(derEncodedFile: path!)!]
    let host = WDB_ServerUrl //本次请求的包含的host
    let policies: [String: ServerTrustPolicy] = [host : .pinCertificates(certificates: certificates, validateCertificateChain: true, validateHost: true)]
    let manager: Manager = Manager(configuration: configuration,
                                   serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
    manager.startRequestsImmediately = true
        return manager
    }


class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    public init() {
        super.init(policies: [:])
    }
}


  //传入证书路径，转为SecCertificate格式
  public func create(derEncodedFile file: String) -> SecCertificate? {
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: file)) else {
        return nil
    }
    let cfData = CFDataCreateWithBytesNoCopy(nil, (data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), data.count, kCFAllocatorNull)
    return SecCertificateCreateWithData(kCFAllocatorDefault, cfData!)
}


//重写MoyaProvider， 封装Token请求
 public class MyMoyaProvider<Target>: MoyaProvider<Target> where Target: Moya.TargetType {
    
    private let disposeBag = DisposeBag()
    private var refreshToken = ""
    private var refreshCount: Int = 0
    private var target: Target?
    private var queue: DispatchQueue?
    private var progress: ProgressBlock?
    private var completion: Completion?
    
    private var authenticationBlock = { (_ done: () -> Void) -> Void in
        print("Execute refresh and after retry")
        done()
    }
    
        override init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                      requestClosure: @escaping RequestClosure = MyMoyaProvider.defaultRequestMapping,
                      stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                      callbackQueue: DispatchQueue? = nil,
                      manager: Manager = MoyaProvider<MultiTarget>.defaultAlamofireManager(),
                      plugins: [PluginType] = [],
                      trackInflights: Bool = false) {
            
            super.init(endpointClosure: endpointClosure,
                       requestClosure: requestClosure,
                       stubClosure: stubClosure,
                       callbackQueue: callbackQueue,
                       manager: manager,
                       plugins: plugins,
                       trackInflights: trackInflights)
            
        }
    
    
    
//    public func request(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
//
//
//    }
//
    
  
    
    @discardableResult
    override public func request(_ target: Target, callbackQueue queue: DispatchQueue?, progress: ProgressBlock? = nil, completion: @escaping Completion) -> Cancellable {
        
        //保存第一次请求的参数
        if self.refreshCount == 0 {
           //self.saveParams(target: target, callbackQueue: queue, progress: progress, completion: completion)
        }
        
        return super.request(target, callbackQueue: queue, progress: progress, completion: {[unowned self]result in
            switch result {
            case let .success(moyaResponse):
                 print("--------------自定义Moya\(moyaResponse.statusCode)\(moyaResponse.request!)")
                 //在这里判断是否是401，即Token过期
                if (moyaResponse.statusCode == 409) {

                    if self.refreshCount > 3 {
                        self.refreshCount = 0
                        completion(result)
                        return
                     }else{
                        self.refreshCount = self.refreshCount + 1
                    }
                    
                    if moyaResponse.request?.allHTTPHeaderFields?.index(forKey: "Authorization") != nil {
                        //WDBGlobalDataUserDefaults.saveToken(token: "")
                        //请求刷新Token的请求
                        let refreshToken = WDBGlobalDataUserDefaults.getRefreshToken()
                        if refreshToken == "" {return}
                        let parameters: Parameters = ["grant_type":"refresh_token", "refresh_token":refreshToken] as [String:Any]
                        
                        defaultProvider.rx.request(MultiTarget(WDBApiLogin.refreshToken(Dict: parameters))).filterSuccessfulStatusCodes().mapJSON().asObservable().mapObject(type: WDBUserToken.self).subscribe(onNext: { [unowned self](tokenInfo) in
                            //保存Token信息
                            WDBGlobalDataUserDefaults.saveToken(token: tokenInfo.access_token ?? "")
                            WDBGlobalDataUserDefaults.saveRefreshToken(refreshToken: tokenInfo.refresh_token ?? "")
                            self.refreshCount = 0
                            //再次发起旧的请求
                           //super.request(target, callbackQueue: queue, progress: progress, completion: completion)
                            //self.requestAgain()
                        }, onError: {(error) in
                            YBProgressHUD.showTipMessage(text: "您的账号权限过期，请重新登录！")
                            //请求错误，直接回到登录页
                            WDBCommonHelper.shared.goBackLoginPage()
                            //清空本地token信息
                            completion(result)
                            //cancelBlock(result)
                        }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
//

//                        completion(result)
//                        let requestUrl = WDB_ServerUrl + "/oauth/token"
//                        let headers = ["Authorization": "Basic dGVzdDp0ZXN0"]
//                        //let manager = defaultAlamofireManagers()
//                        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
//                            switch response.result {
//                            case .success:
//                                print(response.result.value as! NSDictionary)
//                                break
//                            case .failure:
//                                print(response.result.error!)
//                                break
//                            }
//                            print("刷新token\(response)")
//                        })
                        
//                        manager.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
//                            switch response.result {
//                            case .success:
//                                print(response.result.value as! NSDictionary)
//                                break
//
//                            case .failure:
//                                print(response.result.error!)
//                                break
//                            }
//                            print("刷新token\(response)")
//                        })
//
//                        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON(completionHandler: { (response) in
//                            print("刷新token\(response)")
//                            switch (response.result) {
//                            case .success:
//                                print("data - > \n    \(response.data?.debugDescription) \n")
//                                print("response - >\n    \(response.response?.debugDescription) \n")
//                                var statusCode = 0
//                                if let unwrappedResponse = response.response {
//                                    let statusCode = unwrappedResponse.statusCode
//                                }
//                                //self.completionBlock(statusCode, nil)
//
//                                break
//                            case .failure(let error):
//                                print("error - > \n    \(error.localizedDescription) \n")
//                                let statusCode = response.response?.statusCode
//                               // self.completionBlock?(statusCode, error)
//                                break
//                            }
                            
                        //})
                         // self.requestAgain()
                  }
                    
                } else {
                    completion(result)
                }
            case let .failure(error):
                print(error)
            }
            completion(result)
        })
    
    }
}

//    private func saveParams(target: Target, callbackQueue queue: DispatchQueue?, progress: ProgressBlock? = nil, completion: @escaping Completion) {
//        self.target = target
//        self.queue = queue
//        self.progress = progress
//        self.completion = completion
//    }

    //再次请求
//    private func requestAgain() {
//
//        self.request(self.target!, callbackQueue: self.queue, progress: self.progress, completion: self.completion!)
//        //_ = defaultProvider.rx.request(self.target as! MultiTarget, callbackQueue: self.queue).asObservable().retry()
//
//    }

    //request adapter
//
//    class WDBRefreshTokenAdapter: RequestAdapter {
//
//        func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//            var urlRequest = urlRequest
//            let refreshToken = WDBGlobalDataUserDefaults.getRefreshToken()
//            let requestUrl = WDB_ServerUrl + "/oauth/token"
//            let parameters: Parameters = ["grant_type":"refresh_token", "refresh_token":refreshToken]
//            urlRequest = URLRequest.init(url: NSURL.init(string: requestUrl)! as URL)
//            urlRequest.httpMethod = "POST"
//            urlRequest.addValue("Authorization", forHTTPHeaderField: "Basic dGVzdDp0ZXN0")
//            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
//
//            return urlRequest
//        }
//
//    }
//}
//extension MyMoyaProvider: ReactiveCompatible {

//}


public typealias AuthenticationBlock = (_ isAuthenticationSuccess: Bool) -> Void

//处理Token
public func authenticationToken(moyaResponse: Response, _ authenticationBlock: @escaping AuthenticationBlock ) {
    
    if moyaResponse.request?.allHTTPHeaderFields?.index(forKey: "Authorization") != nil {
        
        let refreshToken = WDBGlobalDataUserDefaults.getRefreshToken()
        if refreshToken == "" {return}
        let parameters: Parameters = ["grant_type":"refresh_token", "refresh_token":refreshToken] as [String:Any]
        
        //请求刷新Token
        defaultProvider.request(MultiTarget(WDBApiLogin.refreshToken(Dict: parameters))) { (result) in
            switch result {
              case .success(let response):
                
                if response.statusCode == 401 {
                     authenticationBlock(false)
                    //refreshToken过期，直接退回登陆页
                   
                    //请求错误，直接回到登录页
                  WDBCommonHelper.shared.goBackLoginPage()
                  YBProgressHUD.showTipMessage(text: "您的账号权限过期，请重新登录！")
                }
                
                if response.statusCode == 200 {
                     //保存新的accesstoken和refreshToken
                    if let dict = JSON.init(response.data).dictionaryObject {
                        let refreshToken = dict["refresh_token"] as? String ?? ""
                        let accessToken = dict["access_token"] as? String ?? ""
                        WDBGlobalDataUserDefaults.saveToken(token: accessToken  )
                        WDBGlobalDataUserDefaults.saveRefreshToken(refreshToken: refreshToken)
                    }
                      authenticationBlock(true)
                }
                
                break
               case .failure(let error):
                print("刷新Token出错\(error)")
                  authenticationBlock(false)
                //请求错误，直接回到登录页
                WDBCommonHelper.shared.goBackLoginPage()
                YBProgressHUD.showTipMessage(text: "您的账号权限过期，请重新登录！")
                break
           }
        }
    }
        
        
        
        
 }

public extension Reactive where Base: MoyaProviderType {
    
    /// Designated request-making method.
    ///
    /// - Parameters:
    ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
    ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
    /// - Returns: Single response object.
    public func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        
        
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    //判断Token为是否失效
                    if response.statusCode == 401 {
                        authenticationToken(moyaResponse: response, { isAuthenticationSuccess in
                            if isAuthenticationSuccess == true {
                                //print("tokenValue = \(token.headers)")
                                single(.success(response))
                                //Single.retry(<#T##PrimitiveSequence<SingleTrait, _>#>)
                            }else{
                                single(.success(response))
                            }
                        })
                    }else{
                        single(.success(response))
                    }
                   
                case let .failure(error):
                    single(.error(error))
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    
    /// Designated request-making method with progress.
    public func requestWithProgress(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
        let progressBlock: (AnyObserver) -> (ProgressResponse) -> Void = { observer in
            return { progress in
                observer.onNext(progress)
            }
        }
        
        let response: Observable<ProgressResponse> = Observable.create { [weak base] observer in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: progressBlock(observer)) { result in
                switch result {
                case .success:
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
        
        // Accumulate all progress and combine them when the result comes
        return response.scan(ProgressResponse()) { last, progress in
            let progressObject = progress.progressObject ?? last.progressObject
            let response = progress.response ?? last.response
            return ProgressResponse(progress: progressObject, response: response)
        }
    }
}


