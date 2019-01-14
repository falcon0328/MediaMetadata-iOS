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
    /// GPS
    case gps = "{GPS}"
    /// IPTC
    case iptc = "{IPTC}"
    /// JFIF
    case jfif = "{JFIF}"
    /// TIFF
    case tiff = "{TIFF}"
}
