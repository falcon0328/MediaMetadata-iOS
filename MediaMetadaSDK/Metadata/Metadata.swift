//
//  Metadata.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/07.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// メタデータを表現するためのプロトコル
public protocol Metadata {
    /// メタデータを格納した辞書
    var rawValue: [String: Any] { get }
    /// メタデータの追加
    ///
    /// - Parameters:
    ///   - metadataKey: メタデータのキー
    ///   - value: メタデータとして格納したい値
    /// - Returns: 追加の成否
    func write(metadataKey: String, value: Any) -> Bool
    /// 指定したキー値を持つメタデータの読み込み
    ///
    /// 指定したキー値を持つメタデータが存在しない場合、nilを返す
    /// - Parameter metadataKey: メタデータのキー
    /// - Returns: 指定したキー値を持つメタデータ
    func read(metadataKey: String) -> Any?
}