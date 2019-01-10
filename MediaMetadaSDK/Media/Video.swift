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
    let rawData: Data
    var metadata: [MetadataKey : Metadata]
    
    init(type: MediaType, localIdentifier: String, rawData: Data, metadata: [MetadataKey : Metadata]) {
        self.type = type
        self.localIdentifier = localIdentifier
        self.rawData = rawData
        self.metadata = metadata
    }
    
    /// イニシャライザ
    ///
    /// - Parameters:
    ///   - localIdentifier: 動画のローカル識別子
    ///   - rawData: 動画のデータ
    init(localIdentifier: String, rawData: Data) {
        self.init(type: .video,
                  localIdentifier: localIdentifier,
                  rawData: rawData,
                  metadata: [:])
    }
}
