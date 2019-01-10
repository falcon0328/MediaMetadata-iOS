//
//  Photo.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation


/// 写真データ
struct Photo: Media {
    let type: MediaType
    let localIdentifier: String
    var metadata: [MetadataKey : Metadata]
    
    init(type: MediaType, localIdentifier: String, metadata: [MetadataKey : Metadata]) {
        self.type = type
        self.localIdentifier = localIdentifier
        self.metadata = metadata
    }
    
    /// イニシャライザ
    ///
    /// - Parameters:
    ///   - localIdentifier: 写真のローカル識別子
    ///   - rawData: 写真のデータ
    init(localIdentifier: String) {
        self.init(type: .photo,
                  localIdentifier: localIdentifier,
                  metadata: [:])
    }
    
    func getData(completionHandler: @escaping (Data?) -> Void) {
        
    }
}
