//
//  YBOSSUploader.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/26.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import AliyunOSSiOS

public class YBOSSUploader {
    
    public typealias progressBlock = (_ percent: Float) -> Void
    public var progress: progressBlock?
    
    public typealias resultBlock = (_ result: String) -> Void
    public var resultClourse: resultBlock?
    
    
    public var client = OSSClient()
    public let operationQueue = OperationQueue()
    public var sumPercent: Float = 0
    public var count = 0
    
//    public let accessKey = "p2LrCunAYaVi0ZfR"
//    public let secretKey = "QaUzWsNP1v0DewTpUDu8t7O6F1ihqk"
//    public let endPoint = "https://oss-cn-hangzhou.aliyuncs.com"
    
    private var accessKey:String?
    private var secretKey:String?
    private var ossAliYunHost:String?
    private var ossBucketName:String?
    private var ossFileDir:String?
    
    public static let manager = YBOSSUploader()
    private init () {
        
        self.accessKey = WDBAccountManager.sharedManger.ossInfo?.ossKey ?? ""
        self.secretKey = WDBAccountManager.sharedManger.ossInfo?.ossSecret ?? ""
        self.ossAliYunHost = WDBAccountManager.sharedManger.ossInfo?.ossUrl ?? ""
        self.ossBucketName = WDBAccountManager.sharedManger.ossInfo?.ossBucketName ?? ""
        self.ossFileDir = WDBAccountManager.sharedManger.ossInfo?.ossFileDir ?? ""
        
        configClient()
    }
    
    private func configClient(){
        
        let credential: OSSCredentialProvider = OSSCustomSignerCredentialProvider {(contentToSign, error: NSErrorPointer) -> String? in
            
           let signture = OSSUtil.calBase64Sha1(withData: contentToSign, withSecret: self.secretKey!)
            if signture == nil {
                print(error!)
                return nil
            }
            return "OSS \(String(describing: self.accessKey!)):\(signture!)"
            }!
        
        let aliYunHost = "https://" + self.ossAliYunHost!
        client = OSSClient(endpoint: aliYunHost, credentialProvider: credential)
    }
    
    private func performTask(data: Data,objectType: String) {
        
         print(data, objectType)
        
        let bucketName  = self.ossBucketName!
        
        let operation = YBOSSOperation(data, objectType, bucketName, client, result: {
            result in
            //拼接图片链接
            let imageUrl:String = "https://" + self.ossBucketName! + "." + self.ossAliYunHost! + "/" + objectType
            self.resultClourse!(imageUrl)
        })
     
        operationQueue.addOperation(operation)
    }
    
    private func calculateOperationCount(_ dataDic: NSDictionary) -> Int {
        
        var count = 0
        for key in dataDic.allKeys {
            let keyValue = key as! String
            switch keyValue {
            case "txt":
                
                count += 1
            case "image":
                
                let array = dataDic["image"] as! Array<Any>
                count += array.count
            case "video":
                
                count += 1
            default:
                break
            }
        }
        return count
    }
    
    public func upload(_ dataDic: NSDictionary, result: @escaping resultBlock) {
        
        //self.progress = progress
        self.resultClourse = result
        
        //count = calculateOperationCount(dataDic)
        
        for key in dataDic.allKeys {
            let keyValue = key as! String
            let data = dataDic[key]
            switch keyValue {
            case "txt":
                
                performTask(data: data as! Data, objectType: "Files/txt.txt")
            case "image":
                
                let imageArray = data as! Array<Any>
                if imageArray.count != 0 {
                    for imageData in imageArray {
                        
                        //let timeInterval = NSDate().timeIntervalSince1970 * 1000
                        
                        let identifierStr = UUID().uuidString
                        let  objectType = "\(String(describing: ossFileDir!))" + identifierStr  + ".jpg"
                        
                        print("rrrrrrr\(objectType)")
                        
                        let data: Data = UIImageJPEGRepresentation(imageData as! UIImage, 0.3)!
                        
                        print("ttttttttt\(data)")
                        performTask(data: data, objectType: objectType)
                    }
                }
            case "video":
                
                performTask(data: data as! Data, objectType: "Files/video.mp4")
            default:
                break
            }
        }
    }
}





