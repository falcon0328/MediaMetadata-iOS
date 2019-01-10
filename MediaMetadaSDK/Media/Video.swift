//
//  Video.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import Photos

/// 動画データ
struct Video: Media {
    private let asset: PHAsset
    
    let type: MediaType = .photo
    var localIdentifier: String {
        get {
            return asset.localIdentifier
        }
    }
    var metadata: [MetadataKey : Metadata]
    
    init(asset: PHAsset, metadata: [MetadataKey : Metadata]) {
        self.asset = asset
        self.metadata = metadata
    }
    
    /// イニシャライザ
    ///
    /// - Parameters:
    ///   - asset: メディアのアセットデータ
    init(asset: PHAsset) {
        self.init(asset: asset,
                  metadata: [:])
    }
    
    func getData(completionHandler: @escaping (Data?) -> Void) {
        
    }
    
    func getMetadata(completionHandler: @escaping ([MetadataKey : Metadata]) -> Void) {
        
    }
}
