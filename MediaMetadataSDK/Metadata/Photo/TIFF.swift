//
//  TIFF.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/10.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// TIFFを表す構造体
public struct TIFF: Metadata {
    public var rawValue: Any {
        get {
            return _rawValue
        }
    }
    /// 読み書き可能なデータ
    private var _rawValue: [String : Any]
    
    public init?(rawValue: Any) {
        guard let rawValue = rawValue as? [String: Any] else {
            return nil
        }
        self._rawValue = rawValue
    }
    
    public func read(metadataKey: String) -> Any? {
        return _rawValue[metadataKey]
    }
    public func read() -> Any {
        return rawValue
    }
    
    public mutating func write(metadataKey: String, value: Any) -> Bool {
        _rawValue[metadataKey] = value
        return true
    }
    public mutating func write(value: Any) -> Bool {
        guard let value = value as? [String: Any] else {
            return false
        }
        _rawValue = value
        return true
    }
}
