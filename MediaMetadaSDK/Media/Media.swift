//
//  Media.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/07.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// メタデータを含む画像や動画などのメディアデータを表現するためのプロトコル
public protocol Media {
    /// メディアの種類
    var type: MediaType { get }
    /// カメラロール内でのローカル識別子
    var localIdentifier: String { get }
    /// メディアのバイトデータ
    var rawData: Data { get }
    /// メディアのメタデータ
    var metadata: [MetadataKey: Metadata] { get set }
}
