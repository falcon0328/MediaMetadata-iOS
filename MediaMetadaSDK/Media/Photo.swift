//
//  Photo.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import Photos

/// 写真データ
struct Photo: Media {
    private let asset: PHAsset
    
    let type: MediaType = .photo
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
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        PHImageManager.default().requestImageData(for: asset,
                                                  options: options,
                                                  resultHandler: { data, str, orientation, dict in
            completionHandler(data)
        })
    }
    
    func getMetadata(completionHandler: @escaping ([MetadataKey : Metadata]) -> Void) {
        getData(completionHandler: { data in
            guard let data = data,
                let ciImage = CIImage(data: data) else {
                    return
            }
            var dict: [MetadataKey: Metadata] = [:]
            let properties = ciImage.properties
            for key in properties.keys {
                guard let metadataKey = MetadataKey(rawValue: key),
                    let values = properties[key] as? [String: Any] else {
                        continue
                }
                switch metadataKey {
                case .exif:
                    let exif = EXIF(rawValue: values)
                    dict[.exif] = exif
                default:
                    break
                }
            }
            completionHandler(dict)
        })
    }
}
