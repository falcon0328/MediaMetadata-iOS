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
    var rawValue: Any { get }
    /// メタデータの追加
    ///
    /// - Parameters:
    ///   - metadataKey: メタデータのキー
    ///   - value: メタデータとして格納したい値
    /// - Returns: 追加の成否
    mutating func write(metadataKey: String, value: Any) -> Bool
    mutating func write(value: Any) -> Bool
    /// 指定したキー値を持つメタデータの読み込み
    ///
    /// 指定したキー値を持つメタデータが存在しない場合や格納されているメタデータが辞書型出ない場合はnilを返す
    /// - Parameter metadataKey: メタデータのキー
    /// - Returns: 指定したキー値を持つメタデータ
    func read(metadataKey: String) -> Any?
    /// メタデータの読み込み
    ///
    /// 実際に格納されているメタデータを返す
    /// - Returns: 実際に格納されているメタデータ
    func read() -> Any
}
