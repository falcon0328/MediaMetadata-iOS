//
//  Video.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// 動画データ
struct Video: Media {
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
    ///   - localIdentifier: 動画のローカル識別子
    ///   - rawData: 動画のデータ
    init(localIdentifier: String) {
        self.init(type: .video,
                  localIdentifier: localIdentifier,
                  metadata: [:])
    }
}
