//
//  IPTC.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// IPTCを表す構造体
struct IPTC: Metadata {
    var rawValue: [MetadataKey : Any] {
        get {
            return _rawValue
        }
    }
    /// 読み書き可能なデータ
    private var _rawValue: [MetadataKey : Any] = [:]
    
    mutating func write(metadataKey: MetadataKey, value: Any) -> Bool {
        _rawValue[metadataKey] = value
        return true
    }
}
