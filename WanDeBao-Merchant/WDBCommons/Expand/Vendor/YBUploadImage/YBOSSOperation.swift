//
//  YBOSSOperation.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/26.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit

import UIKit
import AliyunOSSiOS

class YBOSSOperation: Operation {
    
    typealias progressBlock = (_ percent: Float) -> Void
    var progress: progressBlock?
    
    public typealias resultBlock = (_ result: AnyObject) -> Void
    public var resultClourse: resultBlock?
  
    
    fileprivate var fileData = Data()
    fileprivate var objectType = String()
    fileprivate var bucketName = String()
    fileprivate var client = OSSClient()
    
    
    init(_ filedata: Data, _ objectType: String, _ bucketName:String,
         _ client: OSSClient, result: @escaping resultBlock) {
        
        self.client = client
        self.fileData = filedata
        self.objectType = objectType
        self.resultClourse = result
        self.bucketName = bucketName
        
    }
    
    override func main() {
        
        performTask()
    }
    
    func performTask() {
        
        //添加objectType
        let putRequest = OSSPutObjectRequest()
        putRequest.bucketName = self.bucketName
        putRequest.objectKey = self.objectType
        putRequest.uploadingData = self.fileData
       let uploadTask = client.putObject(putRequest)
       uploadTask.continue ({ (uploadTask) -> Any? in
            if let _err = uploadTask.error {
                print(_err)
            } else {
                if (uploadTask.result as? OSSPutObjectResult) != nil {
                    //上传成功后预览地址自行拼接
                    let  result = uploadTask.result!
                    if let clourse = self.resultClourse {
                        clourse(result)
                        print("上传成功")
                    }
                  
                }
            }
            return uploadTask
        })
    }
}

