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
    /// ユーザが書き込んだメディアのメタデータ
    var userMetadata: [MetadataKey: Metadata] { get set }
    /// メディアのバイナリデータ
    ///
    /// - Parameter completionHandler: データ取得結果を得るためのハンドラメソッド
    func getData(completionHandler: @escaping (Data?) -> Void)
    
    /// メディアのメタデータを取得する
    ///
    /// - Parameter completionHandler: メタデータ取得結果を得るためのハンドラメソッド
    func getMetadata(completionHandler: @escaping ([MetadataKey : Metadata]) -> Void)
    /// メタデータを設定する
    ///
    /// - attention:
    /// saveメソッドが呼ばれるまでカメラロールには反映されない
    ///
    /// - Parameters:
    ///   - key: メタデータのキー
    ///   - value: メタデータの値
    mutating func setMetadata(key: MetadataKey, value: Metadata)
}

extension Media {
    mutating func setMetadata(key: MetadataKey, value: Metadata) {
        userMetadata[key] = value
    }
}
