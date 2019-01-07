//
//  MetadataKey.swift
//  MediaMetadaSDK
//
//  Created by aseo on 2019/01/07.
//  Copyright © 2019年 Falcon Tech. All rights reserved.
//

import Foundation

/// メタデータを指定する際に利用する列挙型
public enum MetadataKey: String {
    /// EXIF
    case exif = "{Exif}"
    /// IPTC
    case iptc = "{Iptc}"
    /// JFIF
    case jfif = "{Jfif}"
    /// TIFF
    case tiff = "{Tiff}"
}
