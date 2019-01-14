//
//  YBUploadImageManager.swift
//  WanDeBao-Merchant
//
//  Created by 吴满乐 on 2018/5/26.
//  Copyright © 2018年 Hangzhou YunBao Technology Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD


class YBUploadImageManager: NSObject, UIActionSheetDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    public typealias UploadImageToServerClourse = (_ image: UIImage, _ imageUrl:String) -> Void
    private var uploadImageClourse:UploadImageToServerClourse?
    
    private weak var fatherViewController: UIViewController?
    
    public var isEditPhoto:Bool?
    public static let manager = YBUploadImageManager()
   
    
    func showActionSheetInFatherViewController(fatherVC:UIViewController,  uploadClourse: @escaping UploadImageToServerClourse) {
        
        self.uploadImageClourse = uploadClourse
        self.fatherViewController = fatherVC
        let acctionSheet: UIActionSheet =  UIActionSheet.init(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册上传")
        acctionSheet.show(in: fatherVC.view)
        
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
      
        print(buttonIndex)
        
        if buttonIndex == 1 {
            createPhotoView()
        }
        if buttonIndex == 2 {
            selectImageFromPhotoLibrary()
        }
    }
    
    //拍照
    func createPhotoView() {
        
        let isAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(.camera)
        if isAvailable {
            showImagePickerForSourceType(sourceType:.camera)
        }else {
            let alert = UIAlertView.init(title: "提示", message: "相机不可用", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
    }
    
   //从图片库中选择
    func selectImageFromPhotoLibrary() {
        showImagePickerForSourceType(sourceType: .photoLibrary)
    }
    
    
    func showImagePickerForSourceType(sourceType: UIImagePickerControllerSourceType) {
        
        let delayInSeconds: Double = 0.05;//延迟一点点初始化摄像头，以便于HUD显示出来；不延迟的话，即使在子线程初始化摄像头仍然导致HUD不显示
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute:
            {
               let imagePickerController = UIImagePickerController.init()
               imagePickerController.modalPresentationStyle = .currentContext
               imagePickerController.sourceType = sourceType
                if self.isEditPhoto ?? false {
                    imagePickerController.allowsEditing = false
                }
                imagePickerController.delegate = self
                
                if sourceType == .camera {
                    imagePickerController.showsCameraControls = true
                }
                
                DispatchQueue.main.async(execute: {
                    self.fatherViewController?.navigationController?.present(imagePickerController, animated: true, completion: {
                        UIApplication.shared.statusBarStyle = .default
                    })
                })
        })
        
    }
    
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.fatherViewController?.navigationController?.dismiss(animated: true, completion: {
            
            var image:UIImage = UIImage.init()
            if self.isEditPhoto ?? false {
                //获取编辑后的图片
                image = info[UIImagePickerControllerEditedImage] as! UIImage
            }else {
                //获取原图
                image = info[UIImagePickerControllerOriginalImage] as! UIImage
            }
            
            //图片返回
            if let clourse = self.uploadImageClourse {
                
                let imageDic = NSDictionary.init(dictionary: ["image":[image]])
                
                //上传图片
                YBOSSUploader.manager.upload(imageDic, result: { (result) in
                     print("图片：\(result)")
                     clourse(image, result)
                    //SVProgressHUD.dismiss()
                })
            }
        })
        
    }

}
