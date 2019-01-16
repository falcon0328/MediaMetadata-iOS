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
class Photo: Media {
    private var asset: PHAsset
    
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
    convenience init(asset: PHAsset) {
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
                completionHandler([:])
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
                let values = properties[key] else {
                    continue
            }
            switch metadataKey {
            case .exif:
                let exif = EXIF(rawValue: values)
                dict[.exif] = exif
            case .gps:
                let gps = GPS(rawValue: values)
                dict[.gps] = gps
            case .iptc:
                let iptc = IPTC(rawValue: values)
                dict[.iptc] = iptc
            case .jfif:
                let jfif = JFIF(rawValue: values)
                dict[.jfif] = jfif
            case .tiff:
                let tiff = TIFF(rawValue: values)
                dict[.tiff] = tiff
            case .colorModel:
                let colorModel = PhotoColorModel(rawValue: values)
                dict[.colorModel] = colorModel
            case .orientation:
                let orientation = PhotoOrientation(rawValue: values)
                dict[.orientation] = orientation
            case .pixelWidth:
                let width = PhotoPixelWidth(rawValue: values)
                dict[.pixelWidth] = width
            case .pixelHeight:
                let height = PhotoPixelHeight(rawValue: values)
                dict[.pixelHeight] = height
            case .depth:
                let depth = PhotoDepth(rawValue: values)
                dict[.depth] = depth
            case .profileName:
                let profileName = PhotoProfileName(rawValue: values)
                dict[.profileName] = profileName
            case .dpiWidth:
                let dpiWidth = PhotoDpiWidth(rawValue: values)
                dict[.dpiWidth] = dpiWidth
            case .primaryImage:
                let primaryImage = PhotoPrimaryImage(rawValue: values)
                dict[.primaryImage] = primaryImage
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
                completionHandler(false, createMediaMetadaSDKError(code: MediaMetadataErrorBadPhotoData))
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
            completionHandler(false, createMediaMetadaSDKError(code: MediaMetadataErrorCannotCreateImageData))
            return
        }
        var localID = localIdentifier
        var fileURL: URL!
        let fileName = "\(Int.random(in: 0..<100000000)).jpg"
        do {
            fileURL = try createFileToTemporaryDirectory(fileName: fileName, data: imageData as Data)
        } catch {
            completionHandler(false, createMediaMetadaSDKError(code: MediaMetadataErrorCannotCreatePhotoFile))
            return
        }
        if let fileURL = fileURL {
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: fileURL)
                if let localIdentifier = request?.placeholderForCreatedAsset?.localIdentifier {
                    localID = localIdentifier
                }
            }, completionHandler: { isSuccess, error in
                if !isSuccess {
                    completionHandler(false, createMediaMetadaSDKError(code: MediaMetadataErrorCannotCreatePhotoAsset))
                    return
                }
                _ = try? FileManager.default.removeItem(atPath: fileURL.absoluteString)
                if let newAsset = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil).firstObject {
                    self.asset = newAsset
                } else {
                    completionHandler(false, createMediaMetadaSDKError(code: MediaMetadataErrorCannotUpdatePhotoAsset))
                    return
                }
                self.userMetadata = [:]
                completionHandler(true, nil)
            })
        }
    }
    
    /// CGImageをメタデータ付きの写真データに変換する
    ///
    /// - Parameter image: CGImage型の写真データ
    /// - Returns: メタデータ付きの写真データ
    func createImageData(image: CIImage) -> NSMutableData? {
        var properties = image.properties
        // メタデータの書き換え処理
        for key in userMetadata.keys {
            guard let rawValue = userMetadata[key]?.rawValue else {
                continue
            }
            properties[key.rawValue] = rawValue
        }
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
    func createFileToTemporaryDirectory(fileName: String, data: Data) throws -> URL {
        let filePath = "\(NSTemporaryDirectory())\(fileName)"
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            try data.write(to: fileURL, options: .atomic)
            return fileURL
        } catch {
            throw error
        }
    }
}
