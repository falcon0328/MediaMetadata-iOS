//
//  ViewController.swift
//  MediaMetadata
//
//  Created by aseo on 2019/01/06.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import UIKit
import Photos
import MediaMetadaSDK

class ViewController: UIViewController {
    let exifUserCommentKey = "UserComment"
    let array = ["BDF696F6-8C83-4C51-9051-804A5C0991CA/L0/001"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kariExif = EXIF(rawValue: [exifUserCommentKey: "Hoge Fuga Piyo"])
        
        let medias = MediaLibrary.shared().load(localIdentifier: array)
        for (index, media) in medias.enumerated() {
            var media = medias.object(index: index)
            media.setMetadata(key: .exif, value: kariExif)
            media.save(completionHandler: { isSuccess, error in
                print(isSuccess)
            })
        }
    }


}

