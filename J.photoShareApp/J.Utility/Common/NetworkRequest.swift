//
//  NetworkRequest.swift
//  J.photoShareApp
//
//  Created by JinYoung Lee on 29/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NetworkRequest:NSObject {
    func loadImage(url:URL, listener:((Bool, UIImage?) -> Void)?) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask, true)[0]
            let documentsURL = URL(fileURLWithPath: documentsPath, isDirectory: true)
            let fileURL = documentsURL.appendingPathComponent("image.png")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories]) }
        
        Alamofire.download(url, to:
            destination).responseData { response in
                debugPrint(response)                
                if let data = response.result.value {
                    let image = UIImage(data: data)
                    listener!(true, image)
                } else {
                    listener!(false, nil)
                }
        }
    }
}
