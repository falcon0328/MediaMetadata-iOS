//
//  Audio.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/14.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import Photos

/// 音声データ
struct Audio: Media {
    private let asset: PHAsset
    
    let type: MediaType = .audio
    var localIdentifier: String {
        get {
            return asset.localIdentifier
        }
    }
    var userMetadata: [MetadataKey : Metadata]
    
    init(asset: PHAsset, metadata: [MetadataKey : Metadata]) {
        self.asset = asset
        self.userMetadata = metadata
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
    
    func save(completionHandler: @escaping (Bool, Error?) -> Void) {
        
    }
}
