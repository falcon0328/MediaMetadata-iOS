//
//  JFIF.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// JFIFを表す構造体
struct JFIF: Metadata {
    var rawValue: [String : Any] {
        get {
            return _rawValue
        }
    }
    /// 読み書き可能なデータ
    private var _rawValue: [String : Any] = [:]
    
    init(rawValue: [String: Any]) {
        self._rawValue = rawValue
    }
    
    mutating func write(metadataKey: String, value: Any) -> Bool {
        _rawValue[metadataKey] = value
        return true
    }
}
