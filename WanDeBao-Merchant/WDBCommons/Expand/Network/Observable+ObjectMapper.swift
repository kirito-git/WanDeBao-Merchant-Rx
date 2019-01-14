//
//  Observable+ObjectMapper.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/22.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper
import SwiftyJSON

extension Observable {
    
    func mapObject<T: Mappable>(type: T.Type, key: String? = nil) -> Observable<T> {
        return self.map { response in
            
            print("&&&&&&&&&&&&&=======\(response)")
            
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            if let k = key {
                guard let dictionary = dict[k] as? [String: Any] else {
                    throw RxSwiftMoyaError.ParseJSONError
                }
                return Mapper<T>().map(JSON: dictionary)!
            }
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type, key: String? = nil) -> Observable<[T]> {
        return self.map { response in
            
            if key != nil {
                
                guard let dict = response as? [String: Any] else {
                    throw RxSwiftMoyaError.ParseJSONError
                }
                if let error = self.parseError(response: dict) {
                    throw error
                }
                
                guard let dictionary = dict[key!] as? [[String: Any]] else {
                    throw RxSwiftMoyaError.ParseJSONError
                }
                
                return Mapper<T>().mapArray(JSONArray: dictionary)
            } else {
                
                if let array = response as? [Any], let dicts = array as? [[String:Any]] {
                     return Mapper<T>().mapArray(JSONArray: dicts)
                }
                
                if let responseData = response as? Moya.Response, let array = JSON.init(responseData.data).arrayObject, let dicts = array as? [[String: Any]] {
                    return Mapper<T>().mapArray(JSONArray: dicts)
                }
                
                throw RxSwiftMoyaError.ParseJSONError
            }
        }
    }
    
    
    func mapDictionary(key: String? = nil) -> Observable<[String:Any]> {
        return self.map{ response in
            print("response = \(response)")
            
            
         guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            if key != nil {
                guard let dictionary = dict[key!] as? [String: Any] else {
                    throw RxSwiftMoyaError.ParseJSONError
                }
                return dictionary
            }
            return dict
        }
    }
    
    
    func parseServerError() -> Observable {
        return self.map { (response) in
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            return self as! Element
        }
        
    }
    
    fileprivate func parseError(response: [String: Any]?) -> NSError? {
        var error: NSError?
        if let value = response {
            if let code = value["code"] as? Int, code != 200 {
                var msg = ""
                if let message = value["error"] as? String {
                    msg = message
                }
                error = NSError(domain: "Network", code: code, userInfo: [NSLocalizedDescriptionKey: msg])
            }
        }
        return error
    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}


extension RxSwiftMoyaError: Swift.Error {}



/**
public extension ObservableType where E == Response {
    
    /// Tries to refresh auth token on 401 errors and retry the request.
    /// If the refresh fails, the signal errors.
    public func retryWithAuthIfNeeded() -> Observable<Response> {
        
       return retryWhen { (e) -> Observable<MoyaError> in
            
        Observable<Int>.zip(e, Observable.range(start: 1, count: 3), resultSelector: { $1 }).flatMap { i in
                
          let refreshToken = WDBGlobalDataUserDefaults.getRefreshToken()
          if refreshToken == "" {return}
          let parameters: Parameters = ["grant_type":"refresh_token", "refresh_token":refreshToken]
            defaultProvider.rx.request(MultiTarget(WDBApiLogin.refreshToken(Dict: parameters))).filterSuccessfulStatusAndRedirectCodes().mapObject(WDBUserToken).catchError { error in
                if case Error.StatusCode(let response) = error  {
                    if response.statusCode == 401 {
                        // Logout
                        do {
                            try User.logOut()
                            AlertHelper.show(title: "Error", subTitle: "Please login to continue", actionButton: AlertButton(title: "OK",
                                                                                                                             backgroundColor: Constants.Colors.Blue.regular))
                        } catch _ {
                            log.warning("Failed to logout")
                        }
                    }
                }
                return Observable.error(error)
                }.flatMapLatest { token -> Observable<WDBUserToken> in
                    do {
                       // try token.saveInRealm()
                    } catch let e {
                        log.warning("Failed to save access token")
                        return Observable.error(e)
                    }
                    return Observable.just(token)
            }
            
                
                
                
        }
    }
}

*/



