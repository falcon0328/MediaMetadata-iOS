//
//  Photo.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import Photos
import MobileCoreServices

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
        if let data = self.data {
            save(data: data, completionHandler: completionHandler)
            return
        }
        getData(completionHandler: { data in
            if let data = data {
                self.save(data: data, completionHandler: completionHandler)
            } else {
                // TODO: エラーの内容を決めること
            }
        })
    }
    
    /// 写真データをメタデータ付きでカメラロールに保存する
    ///
    /// - Parameters:
    ///   - data: 写真データ
    ///   - completionHandler: 画像データの保存成否を取得するためのハンドラメソッド
    func save(data: Data, completionHandler: @escaping (Bool, Error?) -> Void) {
        guard let image = CIImage(data: data),
            let imageData = createImageData(image: image) else {
            // TODO: エラーの内容を決めること
            return
        }
        do {
            try createFileToTemporaryDirectory(fileName: "\(Int.random(in: 0..<100000000)).jpg", data: imageData as Data)
        } catch {
            // TODO: エラーの内容を決めること
        }
    }
    
    /// CGImageをメタデータ付きの写真データに変換する
    ///
    /// - Parameter image: CGImage型の写真データ
    /// - Returns: メタデータ付きの写真データ
    func createImageData(image: CIImage) -> NSMutableData? {
        let properties = image.properties
        let imageData = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(imageData, kUTTypeJPEG, 1, nil),
            let createdImage = CIContext().createCGImage(image, from: image.extent) else {
            return nil
        }
        CGImageDestinationAddImage(destination,
                                   createdImage,
                                   properties as CFDictionary)
        CGImageDestinationFinalize(destination)
        return imageData
    }
    
    /// ファイルをTemporary領域に保存する
    ///
    /// - Parameters:
    ///   - fileName: ファイル名
    ///   - data: ファイルとして保存するデータ
    /// - Throws: ファイルが保存できなった場合のエラー
    func createFileToTemporaryDirectory(fileName: String, data: Data) throws {
        let filePath = "\(NSTemporaryDirectory())\(fileName)"
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            throw error
        }
    }
}
