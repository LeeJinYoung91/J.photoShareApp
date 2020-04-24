//
//  PostUploder.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 28/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class PostUploader: NSObject {
    struct Upload_Data{
        var category:String = ""
        var documentRef:DocumentReference?
        var uploadImage:UIImage?
        init(ref:DocumentReference, categoryName:String, image:UIImage?) {
            documentRef = ref
            category = categoryName
            uploadImage = image
        }
    }
    
    private final let Bucket_Path = "gs://jinyoung-bbb95.appspot.com"
    private final let AppName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    private var uploadListener:((Bool)->Void)?
    
    func startUpload(_ data:Posting_Data, listener:((Bool)->Void)?) {
        uploadListener = listener
        let fireStore = Firestore.firestore()
        let document = fireStore.collection(AppName).document(AppName).collection("Post").document("Category") .collection(data.input_category!).document()
        let date_format = DateFormatter()
        date_format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let regist_date = date_format.string(from: Date())
        let uploadDataParam:[String:Any] = ["posting_id":document.documentID, "posting_title":data.input_title ?? "", "posting_content":data.input_content ?? "", "regist_date":regist_date]
        document.setData(uploadDataParam, merge: true) { (error) in
            guard error == nil else {
                self.uploadListener?(false)
                return
            }
            document.getDocument(completion: { (snapShot, error) in
                guard error == nil else {
                    self.uploadListener?(false)
                    return
                }
                
                self.uploadImage(data: Upload_Data(ref: document, categoryName: data.input_category!, image: data.input_img))
            })
        }
    }
    
    private func uploadImage(data:Upload_Data) {
        let firStorage = Storage.storage(url: Bucket_Path)
        let ref = firStorage.reference(withPath: AppName).child("post_images/\(data.documentRef?.documentID)")
        
        if let imageData = data.uploadImage?.jpegData(compressionQuality: 0.7) {
            ref.putData(imageData, metadata: nil) { (metaData, error) in
                guard error == nil else {
                    self.uploadListener?(false)
                    return
                }
                
                ref.downloadURL(completion: { (url, error) in
                    guard let downloadURL = url else {
                        self.uploadListener?(false)
                        return
                    }
                    self.updateDataField(url: downloadURL, data: data)
                })
            }
        }
    }
    
    private func updateDataField(url:URL, data:Upload_Data) {
        data.documentRef?.setData(["image_url":url.absoluteString], merge: true, completion: { (error) in
            guard error == nil else {
                self.uploadListener?(false)
                return
            }
            
            self.uploadListener?(true)
        })
    }
}
