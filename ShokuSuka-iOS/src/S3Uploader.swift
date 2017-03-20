//
//  S3Manager.swift
//  ShokuSuka-iOS
//
//  Created by AtsuyaSato on 2017/03/20.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import AWSS3

class S3Uploader {
    class func configureService() {
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: "", secretKey: "")
        let serviceConfiguration = AWSServiceConfiguration(region: AWSRegionType.APNortheast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
    }
    class func uploadImage(_ uploadImage: UIImage, fileName: String) {
        let transferManager = AWSS3TransferManager.default()
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.bucket = "hakosuka"
        uploadRequest?.key = fileName
        uploadRequest?.body = S3Uploader.generateImageUrl(uploadImage)
        transferManager.upload(uploadRequest!).continueWith(block: { (task: AWSTask) -> Any? in
            if let error = task.error as? NSError {
                if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code) {
                    switch code {
                    case .cancelled, .paused:
                        break
                    default:
                        print("Error uploading: \(uploadRequest?.key) Error: \(error)")
                    }
                } else {
                    print("Error uploading: \(uploadRequest?.key) Error: \(error)")
                }
                return nil
            }
            
            let uploadOutput = task.result
            print("Upload complete for: \(uploadRequest?.key)")
            return nil
        })
    }
    class func generateImageUrl(_ uploadImage: UIImage) -> URL {
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory().appendingFormat("upload.jpg"))
        if let jpegData = UIImageJPEGRepresentation(uploadImage, 80) {
            try! jpegData.write(to: imageURL, options: [.atomicWrite])
        }
        return imageURL
    }
}
