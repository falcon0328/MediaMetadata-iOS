//
//  MediaLibraryManager.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/07.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation
import Photos

/// メディアを管理するためのプロトコル
///
/// - attention:
/// カメラロールの写真や動画を本SDKではメディアと呼んでいる
public protocol MediaLibraryManager {
    /// メディアの読み込み
    ///
    /// - Parameter localIdentifier: カメラロールでのローカル識別子
    /// - Returns: 該当するメディア
    func load(assets: PHFetchResult<PHAsset>) -> [Media]
    /// メディアの削除
    ///
    /// - Parameter localIdentifier: カメラロールでのローカル識別子
    /// - Returns: 削除の成否
    func delete(assets: PHFetchResult<PHAsset>, completionHandler: ((Bool, Error?) -> Void)?)
}
