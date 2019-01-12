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
    var data: Data?
    
    init(asset: PHAsset, metadata: [MetadataKey : Metadata]) {
        self.asset = asset
        self.userMetadata = metadata
    }
    
    /// データからインスタンスを生成する
    ///
    /// - Parameter data: メディアのデータ
    init(data: Data) {
        self.data = data
        self.userMetadata = [:]
        self.asset = PHAsset()
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
        if let data = self.data {
            completionHandler(data)
            return
        }
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        PHImageManager.default().requestImageData(for: asset,
                                                  options: options,
                                                  resultHandler: { data, str, orientation, dict in
            completionHandler(data)
        })
    }
    
    func getMetadata(completionHandler: @escaping ([MetadataKey : Metadata]) -> Void) {
        if let data = self.data {
            getMetadata(data: data, completionHandler: completionHandler)
            return
        }
        getData(completionHandler: { data in
            guard let data = data else {
                    return
            }
            self.getMetadata(data: data, completionHandler: completionHandler)
        })
    }
    
    /// データからメタデータを取得する
    ///
    /// - Parameters:
    ///   - data: 画像のデータ
    ///   - completionHandler: メタデータの取得結果を得るためのハンドラメソッド
    func getMetadata(data: Data, completionHandler: @escaping ([MetadataKey : Metadata]) -> Void) {
        guard let ciImage = CIImage(data: data) else {
            completionHandler([:])
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
            case .iptc:
                let iptc = IPTC(rawValue: values)
                dict[.iptc] = iptc
            case .jfif:
                let jfif = JFIF(rawValue: values)
                dict[.jfif] = jfif
            case .tiff:
                let tiff = TIFF(rawValue: values)
                dict[.tiff] = tiff
            }
        }
        completionHandler(dict)
    }
    
    func save(completionHandler: @escaping (Bool, Error?) -> Void) {
        
    }
}
