//
//  PhotoProfileName.swift
//  MediaMetadataSDK
//
//  Created by aseo on 2019/01/16.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// 写真のプロファイル名を表す構造体
public struct PhotoProfileName: Metadata {
    public var rawValue: Any {
        get {
            return _rawValue
        }
    }
    private var _rawValue: String
    
    public init?(rawValue: Any) {
        guard let rawValue = rawValue as? String else {
            return nil
        }
        _rawValue = rawValue
    }
    
    public func write(metadataKey: String, value: Any) -> Bool {
        return false
    }
    public mutating func write(value: Any) -> Bool {
        guard let value = value as? String else {
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
