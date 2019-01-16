//
//  PhotoOrientation.swift
//  MediaMetadataSDK
//
//  Created by aseo on 2019/01/16.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// 写真の向きを表す構造体
public struct PhotoOrientation: Metadata {
    public var rawValue: Any {
        get {
            return _rawValue
        }
    }
    private var _rawValue: Int
    
    public init?(rawValue: Any) {
        guard let rawValue = rawValue as? Int else {
            return nil
        }
        _rawValue = rawValue
    }
    
    public func write(metadataKey: String, value: Any) -> Bool {
        return false
    }
    public mutating func write(value: Any) -> Bool {
        guard let value = value as? Int else {
            return false
        }
        _rawValue = value
        return true
    }
    
    public func read(metadataKey: String) -> Any? {
        return nil
    }
    public func read() -> Any {
        return rawValue
    }
}
