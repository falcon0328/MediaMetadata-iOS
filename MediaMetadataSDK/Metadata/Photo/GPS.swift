//
//  GPS.swift
//  MediaMetadataSDK
//
//  Created by aseo on 2019/01/15.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// GPSのメタ情報を表す構造体
public struct GPS: Metadata {
    public var rawValue: [String : Any] {
        get {
            return _rawValue
        }
    }
    /// 読み書き可能なデータ
    private var _rawValue: [String : Any]
    
    public init(rawValue: [String: Any]) {
        self._rawValue = rawValue
    }
    
    public func read(metadataKey: String) -> Any? {
        return rawValue[metadataKey]
    }
    
    public mutating func write(metadataKey: String, value: Any) -> Bool {
        _rawValue[metadataKey] = value
        return true
    }
}
