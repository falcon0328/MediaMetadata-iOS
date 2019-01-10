//
//  MediaLibrary.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/07.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import Photos

/// メディアを管理するためのクラス
public class MediaLibrary: MediaLibraryManager {
    private let sharedInstance = MediaLibrary()
    
    private init() {}
    
    public func shared() -> MediaLibraryManager {
        return sharedInstance
    }
    
    public func load(localIdentifier: [String]) -> [Media] {
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: localIdentifier, options: nil)
        var medias: [Media] = []
        for index in (0...assets.count)  {
            var media: Media!
            let asset = assets.object(at: index)
            switch asset.mediaType {
            case .image:
                media = Photo(localIdentifier: asset.localIdentifier)
            case .video:
                media = Video(localIdentifier: asset.localIdentifier)
            case .audio:
                fallthrough
            case .unknown:
                break
            }
            medias.append(media)
        }
        return medias
    }
    
    public func delete(localIdentifier: [String], completion: ((Bool, Error?) -> Void)?) {
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: localIdentifier, options: nil)
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(assets)
        }, completionHandler: completion)
    }
}
