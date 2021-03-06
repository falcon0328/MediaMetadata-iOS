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
    private static let sharedInstance = MediaLibrary()
    
    private init() {}
    
    public static func shared() -> MediaLibraryManager {
        return sharedInstance
    }
    
    public func load(assets: PHFetchResult<PHAsset>) -> [Media] {
        var medias: [Media] = []
        assets.enumerateObjects({ asset, index, pointer in
            var media: Media!
            switch asset.mediaType {
            case .image:
                media = Photo(asset: asset)
            case .video:
                media = Video(asset: asset)
            case .audio:
                fallthrough
            case .unknown:
                break
            }
            medias.append(media)
        })
        return medias
    }
    
    public func delete(assets: PHFetchResult<PHAsset>, completionHandler: ((Bool, Error?) -> Void)?) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(assets)
        }, completionHandler: completionHandler)
    }
}
